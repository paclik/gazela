# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20101011133137) do

  create_table "items", :force => true do |t|
    t.string   "itemid"
    t.float    "diameter"
    t.float    "width"
    t.integer  "weight"
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "place_id"
    t.integer  "bruttoWeight", :limit => 10, :precision => 10, :scale => 0
    t.datetime "placeSince"
  end

  create_table "items_transports", :id => false, :force => true do |t|
    t.integer "item_id"
    t.integer "transport_id"
  end

  create_table "places", :force => true do |t|
    t.string   "name"
    t.string   "location"
    t.string   "invicinity"
    t.integer  "state_id"
    t.string   "district"
    t.text     "note"
    t.string   "issued_who"
    t.string   "change_who"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "address"
  end

  create_table "states", :force => true do |t|
    t.string   "code",       :limit => 5,  :default => "", :null => false
    t.string   "name",       :limit => 50
    t.boolean  "block"
    t.string   "code_nov",   :limit => 5,  :default => "", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "transports", :force => true do |t|
    t.string   "senderRequest"
    t.integer  "loadPlace_id"
    t.integer  "unLoadPlace_id"
    t.string   "vrn"
    t.datetime "loadTime"
    t.datetime "UnLoadTime"
    t.text     "note"
    t.string   "issued_who"
    t.string   "change_who"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "loadUntilTime"
    t.datetime "unLoadUntilTime"
    t.datetime "effectiveLoadTime"
    t.datetime "efectiveUnLoadTime"
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin"
  end

  create_table "wagons", :force => true do |t|
    t.string   "vrn"
    t.string   "wag_type"
    t.integer  "item_id"
    t.integer  "transport_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
