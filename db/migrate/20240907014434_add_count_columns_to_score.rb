class AddCountColumnsToScore < ActiveRecord::Migration[7.2]
  def change
    add_column :scores, :total_final_score, :integer, default: 0
    add_column :scores, :total_pre_banker_score, :integer, default: 0
  end
end
