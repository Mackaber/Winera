class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.string :points_type
      t.decimal :points_bef
      t.string :points_aft
      t.references :user
      t.references :card
      t.references :business
      t.decimal :total
      t.timestamps
    end
    add_index :transactions, :user_id
    add_index :transactions, :card_id
    add_index :transactions, :business_id
  end
end
