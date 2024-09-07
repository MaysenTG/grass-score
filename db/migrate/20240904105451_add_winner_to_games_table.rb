class AddWinnerToGamesTable < ActiveRecord::Migration[7.2]
  def change
    add_reference :games, :winner, foreign_key: { to_table: :players }
  end
end
