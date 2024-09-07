class AddWinningScoreToGames < ActiveRecord::Migration[7.2]
  def change
    add_column :games, :winning_score, :integer, default: 0
  end
end
