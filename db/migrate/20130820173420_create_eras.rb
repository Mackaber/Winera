class CreateEras < ActiveRecord::Migration
  def change
    create_table :eras do |t|
      t.references :business
      t.decimal :era_points
      t.references :card

      t.timestamps
    end
    add_index :eras, :business_id
    add_index :eras, :card_id
  end
end
