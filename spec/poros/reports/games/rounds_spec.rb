require "rails_helper"

RSpec.describe Reports::Games::Rounds do
  describe ".call" do
    let(:account) { create(:account) }
    let(:game) { create(:game, account: account) }
    let!(:players) { create_list(:player, 2, game: game) }

    before do
      round_one = create(:round, game: game, finished: true)
      create(:score, round: round_one, player: players[0], total_final_score: 10)
      create(:score, round: round_one, player: players[1], total_final_score: 15)

      round_two = create(:round, game: game, finished: true)
      create(:score, round: round_two, player: players[0], total_final_score: 5)
      create(:score, round: round_two, player: players[1], total_final_score: 25)
    end

    it "starts each player's cumulative series at zero" do
      result = described_class.call(game)

      expect(result[:categories]).to eq(["Round 0", "Round 1", "Round 2"])
      expect(result[:series].map { |series| series[:data] }).to eq([
        [0, 10, 15],
        [0, 15, 40],
      ])
      expect(result[:series].map { |series| series[:perRoundScores] }).to eq([
        [0, 10, 5],
        [0, 15, 25],
      ])
    end
  end
end
