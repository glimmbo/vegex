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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_02_08_010521) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "trade_events", force: :cascade do |t|
    t.string "type", null: false
    t.integer "trade_id", null: false
    t.text "data", null: false
    t.text "metadata", null: false
    t.datetime "created_at", null: false
    t.index ["trade_id"], name: "index_trade_events_on_trade_id"
  end

  create_table "trades", force: :cascade do |t|
    t.string "phase"
    t.integer "user_id"
    t.string "produce"
    t.integer "quantity"
    t.integer "offer_user_id"
    t.string "offer_produce"
    t.integer "offer_quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "location"
    t.float "trade_completion"
    t.integer "trade_slots"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
