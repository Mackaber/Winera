# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140222175219) do

  create_table "businesses", :force => true do |t|
    t.string   "name"
    t.string   "image"
    t.string   "phone"
    t.text     "description"
    t.string   "category"
    t.integer  "user_id"
    t.string   "streetadr"
    t.decimal  "lat"
    t.decimal  "long"
    t.text     "schedule"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.decimal  "percentage"
    t.decimal  "lvl1_prc",    :default => 0.05
    t.decimal  "lvl2_prc",    :default => 0.05
    t.decimal  "lvl3_prc",    :default => 0.05
    t.decimal  "lvl4_prc",    :default => 0.05
    t.decimal  "lvl5_prc",    :default => 0.05
    t.decimal  "goal",        :default => 500.0
  end

  add_index "businesses", ["user_id"], :name => "index_businesses_on_user_id"

  create_table "cards", :force => true do |t|
    t.string   "code"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "user_id"
    t.integer  "business_id"
  end

  add_index "cards", ["business_id"], :name => "index_cards_on_business_id"
  add_index "cards", ["user_id"], :name => "index_cards_on_user_id"

  create_table "eras", :force => true do |t|
    t.integer  "business_id"
    t.decimal  "era_points"
    t.integer  "card_id"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.integer  "exp",         :default => 0
    t.integer  "level",       :default => 1
  end

  add_index "eras", ["business_id"], :name => "index_eras_on_business_id"
  add_index "eras", ["card_id"], :name => "index_eras_on_card_id"

  create_table "events", :force => true do |t|
    t.text     "description", :default => ""
    t.integer  "exp_gain",    :default => 5
    t.boolean  "condition",   :default => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  create_table "messages", :force => true do |t|
    t.string   "content",    :default => ""
    t.boolean  "seen",       :default => false
    t.string   "link",       :default => "http://app.winero.mx"
    t.integer  "user_id"
    t.datetime "created_at",                                     :null => false
    t.datetime "updated_at",                                     :null => false
  end

  add_index "messages", ["user_id"], :name => "index_messages_on_user_id"

  create_table "summaries", :force => true do |t|
    t.integer  "transaction_id"
    t.integer  "event_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "summaries", ["event_id"], :name => "index_summaries_on_event_id"
  add_index "summaries", ["transaction_id"], :name => "index_summaries_on_transaction_id"

  create_table "transactions", :force => true do |t|
    t.string   "points_type"
    t.decimal  "points_bef"
    t.integer  "user_id"
    t.integer  "card_id"
    t.integer  "business_id"
    t.decimal  "total"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.integer  "era_id"
    t.decimal  "points_aft"
    t.boolean  "prepaid",     :default => false
  end

  add_index "transactions", ["business_id"], :name => "index_transactions_on_business_id"
  add_index "transactions", ["card_id"], :name => "index_transactions_on_card_id"
  add_index "transactions", ["era_id"], :name => "index_transactions_on_era_id"
  add_index "transactions", ["user_id"], :name => "index_transactions_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "last_name"
    t.string   "email"
    t.string   "phone"
    t.string   "provider"
    t.decimal  "win_points"
    t.string   "zipcode"
    t.string   "streetadr"
    t.string   "city_state"
    t.string   "sex"
    t.boolean  "newuser",                :default => true
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.string   "uid"
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
    t.string   "image"
    t.string   "encrypted_password",     :default => "",   :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.date     "birthday"
    t.string   "role"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
