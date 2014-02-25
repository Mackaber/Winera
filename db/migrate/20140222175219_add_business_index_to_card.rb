class AddBusinessIndexToCard < ActiveRecord::Migration

  def change
    change_table :cards do |t|
      t.references :business
    end
    add_index :cards, :business_id
  end

end
