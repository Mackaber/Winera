class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :content, :default => ""
      t.boolean :seen, :default => false
      t.string :link, :default => "http://app.winero.mx"
      t.references :user

      t.timestamps
    end
    add_index :messages, :user_id
  end
end
