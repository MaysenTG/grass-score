class AddUserIdToPlayers < ActiveRecord::Migration[7.2]
  def change
    add_column :players, :user_id, :integer
    add_index :players, :user_id
  end
end
