class AddGameIdToRounds < ActiveRecord::Migration[7.2]
  def change
    add_reference :rounds, :game, null: false, foreign_key: true
  end
end
