class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.text :description, :default => ""
      t.integer :exp_gain, :default => 5
      t.boolean :condition, :default => false

      t.timestamps
    end
  end
end
