class AddUserReferenceToCards < ActiveRecord::Migration
  def change
    change_table :cards do |t|
      t.references :user
    end
    add_index :cards, :user_id
  end
end
