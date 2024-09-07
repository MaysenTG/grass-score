class AddWinnerToRound < ActiveRecord::Migration[7.2]
  def change
    add_column :rounds, :winner_id, :bigint
    add_foreign_key :rounds, :players, column: :winner_id
  end
end
