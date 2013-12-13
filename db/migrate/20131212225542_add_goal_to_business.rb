class AddGoalToBusiness < ActiveRecord::Migration
  def change
    add_column :businesses, :goal, :decimal, :default => 500.0
  end
end
