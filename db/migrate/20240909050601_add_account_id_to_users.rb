class AddAccountIdToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :account_id, :integer
  end
end
