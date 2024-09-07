class CreateScores < ActiveRecord::Migration[7.2]
  def change
    create_table :scores do |t|
      t.references :round, null: false, foreign_key: true
      t.references :players, null: false, foreign_key: true

      t.timestamps
    end
  end
end
