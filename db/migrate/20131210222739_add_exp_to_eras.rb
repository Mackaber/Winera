class AddExpToEras < ActiveRecord::Migration
  def change
    add_column :eras, :exp, :integer, :default => 0
    add_column :eras, :level, :integer, :default => 1
  end
end
