class AddAccountIdToGames < ActiveRecord::Migration[7.2]
  def change
    add_column :games, :account_id, :integer
    add_index :games, :account_id
  end
end
