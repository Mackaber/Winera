class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :last_name
      t.string :email
      t.string :phone
      t.string :provider
      t.decimal :win_points
      t.string :birthdate_date
      t.string :zipcode
      t.string :streetadr
      t.string :city_state
      t.string :sex
      t.boolean :newuser
      t.string :oauth_token
      t.datetime :oauth_expires_at
      t.string :uid

      t.timestamps
    end
  end
end
