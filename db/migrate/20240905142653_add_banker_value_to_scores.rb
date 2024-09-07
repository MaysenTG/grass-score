class AddBankerValueToScores < ActiveRecord::Migration[7.2]
  def change
    add_column :scores, :banker_value, :integer, default: 0, null: false
  end
end
