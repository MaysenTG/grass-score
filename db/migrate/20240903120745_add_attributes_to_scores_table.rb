class AddAttributesToScoresTable < ActiveRecord::Migration[7.2]
  def change
    add_column :scores, :unprotected_peddle, :integer, default: 0, null: false
    add_column :scores, :protected_peddle, :integer, default: 0, null: false
    add_column :scores, :num_sold_out, :integer, default: 0, null: false
    add_column :scores, :num_double_crossed, :integer, default: 0, null: false
    add_column :scores, :num_utterly_wiped_out, :integer, default: 0, null: false
    add_column :scores, :banker, :boolean, default: false, null: false
  end
end
