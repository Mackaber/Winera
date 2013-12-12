class AddIndexToTransaction < ActiveRecord::Migration
  def change
    change_table :transactions do |t|
      t.references :era
    end
    add_index :transactions, :era_id
  end
end
