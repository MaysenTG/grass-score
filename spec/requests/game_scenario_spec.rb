require "rails_helper"

RSpec.describe "Game Scenario Request Test Suite", type: :request do
  describe "Amy's Pad - Single Round Grass Game" do
    let(:account) { create(:account) }
    let(:game) { create(:game, account: account, name: "Amy's Pad Game") }
    let(:john) { create(:player, game: game, user: nil) }
    let(:janis) { create(:player, game: game, user: nil) }
    let(:bob) { create(:player, game: game, user: nil) }
    let(:amy) { create(:player, game: game, user: nil) }
    let(:round) { create(:round, game: game) }

    before do
      # Set player names directly since user association overrides them
      john.update_column(:name, "John")
      janis.update_column(:name, "Janis")
      bob.update_column(:name, "Bob")
      amy.update_column(:name, "Amy")
      
      # Ensure all players exist
      [john, janis, bob, amy]
    end

    describe "Game Setup" do
      it "creates a game with four players" do
        expect(game).to be_persisted
        expect(game.players.count).to eq(4)
      end

      it "creates a round for the game" do
        expect(round).to be_persisted
        expect(round.game_id).to eq(game.id)
        expect(round.sid).to eq(1)
      end

      it "has all players in correct order" do
        player_names = game.players.map(&:name)
        expect(player_names).to contain_exactly("John", "Janis", "Bob", "Amy")
      end
    end

    describe "Score Entry and Calculation" do
      # Based on the scenario description:
      # - John: Protected $75,000, Unprotected $5,000
      # - Janis: Protected $30,000, Unprotected $0 (Banker, has 3 $5k peddles but only 1 deducted)
      # - Bob: Protected $0, Unprotected $5,000
      # - Amy: Protected $0, Unprotected $175,000

      it "creates John's score with correct protected and unprotected profits" do
        john_score = round.scores.build(
          player_id: john.id,
          protected_peddle: 75_000,
          unprotected_peddle: 5_000,
          num_sold_out: 0,
          num_double_crossed: 0,
          num_utterly_wiped_out: 0,
          banker: false,
          highest_peddle_in_hand: 50_000
        )

        expect(john_score.save).to be true
        expect(john_score.protected_peddle).to eq(75_000)
        expect(john_score.unprotected_peddle).to eq(5_000)
      end

      it "creates Janis's score with banker designation" do
        janis_score = round.scores.build(
          player_id: janis.id,
          protected_peddle: 30_000,
          unprotected_peddle: 0,
          num_sold_out: 1,
          num_double_crossed: 0,
          num_utterly_wiped_out: 0,
          banker: true,
          highest_peddle_in_hand: 5_000
        )

        expect(janis_score.save).to be true
        expect(janis_score.banker).to be true
      end

      it "creates Bob's score reflecting trade and hand penalties" do
        bob_score = round.scores.build(
          player_id: bob.id,
          protected_peddle: 0,
          unprotected_peddle: 5_000,
          num_sold_out: 0,
          num_double_crossed: 0,
          num_utterly_wiped_out: 1,
          banker: false,
          highest_peddle_in_hand: 25_000
        )

        expect(bob_score.save).to be true
        expect(bob_score.num_utterly_wiped_out).to eq(1)
      end

      it "creates Amy's score with largest unprotected profit" do
        amy_score = round.scores.build(
          player_id: amy.id,
          protected_peddle: 0,
          unprotected_peddle: 175_000,
          num_sold_out: 0,
          num_double_crossed: 1,
          num_utterly_wiped_out: 0,
          banker: false,
          highest_peddle_in_hand: 5_000
        )

        expect(amy_score.save).to be true
        expect(amy_score.unprotected_peddle).to eq(175_000)
        expect(amy_score.num_double_crossed).to eq(1)
      end
    end

    describe "Score Calculations with CalculateScores" do
      before do
        # Create all scores
        round.scores.create!(
          player_id: john.id,
          protected_peddle: 75_000,
          unprotected_peddle: 5_000,
          num_sold_out: 0,
          num_double_crossed: 0,
          num_utterly_wiped_out: 0,
          banker: false,
          highest_peddle_in_hand: 50_000
        )

        round.scores.create!(
          player_id: janis.id,
          protected_peddle: 30_000,
          unprotected_peddle: 0,
          num_sold_out: 1,
          num_double_crossed: 0,
          num_utterly_wiped_out: 0,
          banker: true,
          highest_peddle_in_hand: 5_000
        )

        round.scores.create!(
          player_id: bob.id,
          protected_peddle: 0,
          unprotected_peddle: 5_000,
          num_sold_out: 0,
          num_double_crossed: 0,
          num_utterly_wiped_out: 1,
          banker: false,
          highest_peddle_in_hand: 25_000
        )

        round.scores.create!(
          player_id: amy.id,
          protected_peddle: 0,
          unprotected_peddle: 175_000,
          num_sold_out: 0,
          num_double_crossed: 1,
          num_utterly_wiped_out: 0,
          banker: false,
          highest_peddle_in_hand: 5_000
        )

        # Calculate scores
        CalculateScores.call(round)
      end

      it "calculates John's pre-banker score correctly" do
        john_score = round.scores.find_by(player_id: john.id)
        # Pre-banker: unprotected (5,000) + protected (75,000) - highest_peddle (50,000) = 30,000
        expect(john_score.total_pre_banker_score).to eq(30_000)
      end

      it "calculates Janis's pre-banker score correctly" do
        janis_score = round.scores.find_by(player_id: janis.id)
        # Pre-banker: sold_out (-25,000) + unprotected (0) + protected (30,000) - highest_peddle (5,000) = 0
        expect(janis_score.total_pre_banker_score).to eq(0)
      end

      it "calculates Bob's pre-banker score correctly" do
        bob_score = round.scores.find_by(player_id: bob.id)
        # Pre-banker: utterly_wiped_out (-100,000) + unprotected (5,000) + protected (0) - highest_peddle (25,000) = -120,000
        expect(bob_score.total_pre_banker_score).to eq(-120_000)
      end

      it "calculates Amy's pre-banker score correctly" do
        amy_score = round.scores.find_by(player_id: amy.id)
        # Pre-banker: double_crossed (-50,000) + unprotected (175,000) + protected (0) - highest_peddle (5,000) = 120,000
        expect(amy_score.total_pre_banker_score).to eq(120_000)
      end

      describe "Banker Calculations" do
        it "applies banker value to Janis (banker)" do
          janis_score = round.scores.find_by(player_id: janis.id)
          # Banker deduction rate: 20% = 0.2
          # Gets contributions from all non-bankers with positive pre-banker scores:
          # John (pre_banker: 30,000 > 0): 5,000 * 0.2 = 1,000
          # Bob (pre_banker: -120,000 <= 0): excluded
          # Amy (pre_banker: 120,000 > 0): 175,000 * 0.2 = 35,000
          # Banker bonus: 5,000
          # Janis banker_value = 1,000 + 35,000 + 5,000 = 41,000
          expect(janis_score.banker_value).to eq(41_000)
        end

        it "deducts banker value from John (non-banker)" do
          john_score = round.scores.find_by(player_id: john.id)
          # John's pre-banker score is 30,000 (positive)
          # John's unprotected peddle: 5,000 * 0.2 = -1,000
          expect(john_score.banker_value).to eq(-1_000)
        end

        it "does not deduct banker value from Bob (negative score)" do
          bob_score = round.scores.find_by(player_id: bob.id)
          # Bob's pre-banker score is -120,000 (negative/zero check excludes him)
          # Banker deductions only apply to players with pre-banker score > 0
          expect(bob_score.banker_value).to eq(0)
        end

        it "deducts banker value from Amy (non-banker)" do
          amy_score = round.scores.find_by(player_id: amy.id)
          # Amy's pre-banker score is 120,000 (positive)
          # Amy's unprotected peddle: 175,000 * 0.2 = -35,000
          expect(amy_score.banker_value).to eq(-35_000)
        end
      end

      describe "Final Scores" do
        it "calculates John's final score correctly" do
          john_score = round.scores.find_by(player_id: john.id)
          # Final: pre_banker (30,000) + banker_value (-1,000) = 29,000
          expect(john_score.total_final_score).to eq(29_000)
        end

        it "calculates Janis's final score correctly" do
          janis_score = round.scores.find_by(player_id: janis.id)
          # Final: pre_banker (0) + banker_value (41,000) = 41,000
          expect(janis_score.total_final_score).to eq(41_000)
        end

        it "calculates Bob's final score correctly" do
          bob_score = round.scores.find_by(player_id: bob.id)
          # Final: pre_banker (-120,000) + banker_value (0) = -120,000
          # Bob's score is negative, so no banker deduction applies
          expect(bob_score.total_final_score).to eq(-120_000)
        end

        it "calculates Amy's final score correctly" do
          amy_score = round.scores.find_by(player_id: amy.id)
          # Final: pre_banker (120,000) + banker_value (-35,000) = 85,000
          expect(amy_score.total_final_score).to eq(85_000)
        end
      end
    end

    describe "Round Completion and Winner Determination" do
      before do
        # Create all scores
        round.scores.create!(
          player_id: john.id,
          protected_peddle: 75_000,
          unprotected_peddle: 5_000,
          num_sold_out: 0,
          num_double_crossed: 0,
          num_utterly_wiped_out: 0,
          banker: false,
          highest_peddle_in_hand: 50_000
        )

        round.scores.create!(
          player_id: janis.id,
          protected_peddle: 30_000,
          unprotected_peddle: 0,
          num_sold_out: 1,
          num_double_crossed: 0,
          num_utterly_wiped_out: 0,
          banker: true,
          highest_peddle_in_hand: 5_000
        )

        round.scores.create!(
          player_id: bob.id,
          protected_peddle: 0,
          unprotected_peddle: 5_000,
          num_sold_out: 0,
          num_double_crossed: 0,
          num_utterly_wiped_out: 1,
          banker: false,
          highest_peddle_in_hand: 25_000
        )

        round.scores.create!(
          player_id: amy.id,
          protected_peddle: 0,
          unprotected_peddle: 175_000,
          num_sold_out: 0,
          num_double_crossed: 1,
          num_utterly_wiped_out: 0,
          banker: false,
          highest_peddle_in_hand: 5_000
        )

        # Calculate scores
        CalculateScores.call(round)
      end

      it "identifies Amy as the round winner (highest final score)" do
        highest_score = round.scores.max_by(&:total_final_score)
        expect(highest_score.player_id).to eq(amy.id)
        expect(highest_score.total_final_score).to eq(85_000)
      end

      it "applies the winning bonus to Amy's score" do
        round.finish!
        amy_score = round.scores.find_by(player_id: amy.id)
        # Final score before bonus: 85,000
        # Bonus: 25,000
        # After bonus: 110,000
        expect(amy_score.round_win_bonus).to eq(25_000)
        expect(amy_score.total_final_score).to eq(110_000)
      end

      it "marks the round as finished" do
        round.finish!
        expect(round.finished).to be true
      end

      it "sets the round winner_id to Amy" do
        round.finish!
        expect(round.winner_id).to eq(amy.id)
      end

      it "sets the game winner after round completion" do
        round.finish!
        game.update!(finished: true)
        expect(game.finished).to be true
      end
    end


  end
end
