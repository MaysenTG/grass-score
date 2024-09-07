class AddSidUniqueToGameField < ActiveRecord::Migration[7.2]
  def change
    # Remove the existing sid column if it exists
    remove_column :rounds, :sid if column_exists?(:rounds, :sid)

    # Add the sid column with auto-increment
    add_column :rounds, :sid, :serial, null: false

    # Add a unique index to the rounds table
    add_index :rounds, [:game_id, :sid], unique: true
  end
end
