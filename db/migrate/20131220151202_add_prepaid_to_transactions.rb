class AddPrepaidToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :prepaid, :boolean, :default => false
  end
end
