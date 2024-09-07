class AddPlayerIdToScoresTable < ActiveRecord::Migration[7.2]
  def change
    # Remove the players_id column from the scores table
    remove_reference :scores, :players, null: false, foreign_key: true

    # Add the player_id column to the scores table
    add_reference :scores, :player, null: false, foreign_key: true
  end
end
