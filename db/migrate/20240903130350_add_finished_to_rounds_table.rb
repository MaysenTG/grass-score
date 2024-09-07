class AddFinishedToRoundsTable < ActiveRecord::Migration[7.2]
  def change
    add_column :rounds, :finished, :boolean, default: false, null: false
  end
end
