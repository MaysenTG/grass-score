class CreateRounds < ActiveRecord::Migration[7.2]
  def change
    create_table :rounds do |t|
      t.timestamps

      t.references :game, null: false, foreign_key: true
    end
  end
end
