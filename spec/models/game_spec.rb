require "rails_helper"

RSpec.describe Game, type: :model do
  describe "associations" do
    it { should belong_to(:account) }
    it { should have_many(:players).dependent(:destroy) }
    it { should have_many(:rounds).dependent(:destroy) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }

    describe "#can_be_finished?" do
      context "when the game has no rounds" do
        let(:game) { create(:game) }

        before do
          create_list(:player, 2, game: game)
        end

        it "returns an error that the game can't be finished because it has no rounds" do
          game.finished = true
          expect(game).to_not be_valid
          expect(game.errors.full_messages).to include("This game has no rounds and can't be finished")
        end
      end

      context "when the game has an in progress round" do
        let(:game) { create(:game) }

        before do
          create_list(:player, 2, game: game)
          create(:round, game: game, finished: false)
        end

        it "returns an error that the game can't be finished because it has an in progress round" do
          game.finished = true
          expect(game).to_not be_valid
          expect(game.errors.full_messages).to include("This game has an in progress round and can't be finished")
        end
      end
    end
  end
end
