class CreateBusinesses < ActiveRecord::Migration
  def change
    create_table :businesses do |t|
      t.string :name
      t.string :image
      t.string :phone
      t.text :description
      t.string :category
      t.references :user
      t.string :streetadr
      t.decimal :lat
      t.decimal :long
      t.text :schedule

      t.timestamps
    end
    add_index :businesses, :user_id
  end
end
