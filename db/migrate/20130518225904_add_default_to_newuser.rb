class AddDefaultToNewuser < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.change :newuser, :boolean, :default => true
    end
  end
end
