class AddPercentageToBusinesses < ActiveRecord::Migration
  def change
    add_column :businesses, :percentage, :decimal
  end
end
