class ChangePointsaftType < ActiveRecord::Migration
  def change
    add_column :transactions, :points_aft_tmp, :decimal

    Transaction.reset_column_information
    Transaction.all.each do |transaction|
      transaction.points_aft_tmp = transaction.points_aft
      transaction.save
    end

    remove_column :transactions, :points_aft

    add_column :transactions, :points_aft, :decimal

    Transaction.reset_column_information
    Transaction.all.each do |transaction|
      transaction.points_aft = transaction.points_aft_tmp
      transaction.save
    end

    remove_column :transactions, :points_aft_tmp
  end
end
