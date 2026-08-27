# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Score, type: :model do
  describe 'peddle validation' do
    let(:game) { create(:game) }
    let!(:player_one) { create(:player, game: game) }
    let!(:player_two) { create(:player, game: game) }
    let(:round) { create(:round, game: game) }
    let(:player) { player_one }
    let(:base_score) do
      {
        round: round,
        player: player,
        num_sold_out: 0,
        num_double_crossed: 0,
        num_utterly_wiped_out: 0,
        banker: false,
        highest_peddle_in_hand: 25_000
      }
    end

    it 'accepts valid values in 5,000 increments' do
      score = described_class.new(**base_score, protected_peddle: 25_000, unprotected_peddle: 15_000)

      expect(score).to be_valid
    end

    it 'rejects values that are not in 5,000 increments' do
      score = described_class.new(**base_score, protected_peddle: 22_000, unprotected_peddle: 15_000)

      expect(score).not_to be_valid
      expect(score.errors[:protected_peddle]).to include('must be in increments of 5,000')
    end
  end

  describe 'banker scoring' do
    let(:game) { create(:game) }
    let!(:player_one) { create(:player, game: game) }
    let!(:player_two) { create(:player, game: game) }
    let(:round) { create(:round, game: game) }

    it 'pays the banker an extra 5k for holding the banker card' do
      banker_score = create(:score,
        round: round,
        player: player_one,
        banker: true,
        protected_peddle: 0,
        unprotected_peddle: 30_000,
        highest_peddle_in_hand: 25_000,
        num_sold_out: 0,
        num_double_crossed: 0,
        num_utterly_wiped_out: 0)

      other_score = create(:score,
        round: round,
        player: player_two,
        banker: false,
        protected_peddle: 0,
        unprotected_peddle: 30_000,
        highest_peddle_in_hand: 25_000,
        num_sold_out: 0,
        num_double_crossed: 0,
        num_utterly_wiped_out: 0)

      CalculateScores.call(round)

      expect(banker_score.reload.banker_value).to eq(11_000)
      expect(other_score.reload.banker_value).to eq(-6_000)
      expect(banker_score.reload.total_final_score).to eq(16_000)
      expect(other_score.reload.total_final_score).to eq(-1_000)
    end
  end
end
