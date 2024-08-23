# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_08_23_103913) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "description"
    t.datetime "start_date"
    t.integer "number_of_acts"
    t.bigint "venue_id"
    t.boolean "is_locked", default: false
    t.string "category"
    t.index ["venue_id"], name: "index_events_on_venue_id"
  end

  create_table "teams", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.bigint "event_id", null: false
    t.string "status", default: "pending"
    t.index ["event_id"], name: "index_teams_on_event_id"
    t.index ["user_id"], name: "index_teams_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "role"
    t.string "name"
    t.jsonb "socials", default: {}
    t.string "phone"
    t.jsonb "members", default: {}
    t.text "description"
    t.string "avatar"
    t.string "banner"
    t.string "city"
    t.jsonb "styles", default: []
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "venues", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "description"
    t.string "lodging"
    t.string "scene_size"
    t.string "paying"
    t.integer "capacity"
    t.bigint "user_id"
    t.string "category"
    t.string "street"
    t.string "city"
    t.string "zipcode"
    t.string "country"
    t.index ["user_id"], name: "index_venues_on_user_id"
  end

  add_foreign_key "events", "venues"
  add_foreign_key "teams", "events"
  add_foreign_key "teams", "users"
  add_foreign_key "venues", "users"
end
