class AddFinishedToGamesTable < ActiveRecord::Migration[7.2]
  def change
    add_column :games, :finished, :boolean, default: false, null: false
  end
end
