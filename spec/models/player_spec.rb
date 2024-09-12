require "rails_helper"

RSpec.describe Player, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:game) }
    it { is_expected.to belong_to(:user).optional }
    it { is_expected.to have_many(:scores).dependent(:destroy) }
    it { is_expected.to have_many(:winning_rounds).class_name("Round").with_foreign_key("winner_id").dependent(:nullify) }
  end

  describe "name" do
    context "when the player is linked to a user" do
      let(:user) { create(:user) }
      let(:player) { create(:player, user: user) }

      it "returns the user's name" do
        expect(player.name).to eq(user.name)
      end
    end
  end

  describe "validations" do
    context "when the player is in an unfinished game" do
      let(:game) { create(:game) }

      before do
        create_list(:player, 2, game: game)
        create(:round, game: game, finished: false)
      end
    end
  end
end
