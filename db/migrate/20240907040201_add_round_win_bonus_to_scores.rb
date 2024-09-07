class AddRoundWinBonusToScores < ActiveRecord::Migration[7.2]
  def change
    add_column :scores, :round_win_bonus, :integer, default: 0
  end
end
