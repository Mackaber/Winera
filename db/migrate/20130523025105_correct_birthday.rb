class CorrectBirthday < ActiveRecord::Migration
  def up
    remove_column :users, :"birthdate_date"
    add_column :users, :"birthday", :date
  end

  def down
  end
end
