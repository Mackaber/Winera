class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.string :code
      t.decimal :era_points
      t.references :business

      t.timestamps
    end
    add_index :cards, :business_id
  end
end
