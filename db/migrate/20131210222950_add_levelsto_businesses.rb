class AddLevelstoBusinesses < ActiveRecord::Migration
  def change
    add_column :businesses, :lvl1_prc, :decimal, :default => 0.05
    add_column :businesses, :lvl2_prc, :decimal, :default => 0.05
    add_column :businesses, :lvl3_prc, :decimal, :default => 0.05
    add_column :businesses, :lvl4_prc, :decimal, :default => 0.05
    add_column :businesses, :lvl5_prc, :decimal, :default => 0.05
  end
end
