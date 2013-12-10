class AddEncryptedpasswordToUser < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :encrypted_password, :default => "",   :null => false
    end
  end
end
