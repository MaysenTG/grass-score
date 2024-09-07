class AddHighestPeddleInHandToScore < ActiveRecord::Migration[7.2]
  def change
    # Make this an enum
    add_column :scores, :highest_peddle_in_hand, :integer, default: 0
  end
end
