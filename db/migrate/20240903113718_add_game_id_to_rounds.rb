class AddGameIdToRounds < ActiveRecord::Migration[7.2]
  def up
    add_reference :rounds, :game, null: false, foreign_key: true unless column_exists? :rounds, :game_id
  end

  def down
    remove_reference :rounds, :game, index: true if column_exists? :rounds, :game_id
  end
end
