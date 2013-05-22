class AddDefaultToNewuser < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.change :newuser, :default => true
    end
  end
end
