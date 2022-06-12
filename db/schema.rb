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

ActiveRecord::Schema[7.0].define(version: 2022_06_12_110303) do
  create_table "djs", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_djs_on_email", unique: true
  end

  create_table "events", force: :cascade do |t|
    t.datetime "start_at", precision: nil
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "place_id"
  end

  create_table "identities", force: :cascade do |t|
    t.string "provider"
    t.string "provider_id"
    t.json "provider_info"
    t.integer "dj_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dj_id"], name: "index_identities_on_dj_id"
    t.index ["provider", "provider_id"], name: "index_identities_on_provider_and_provider_id", unique: true
  end

  create_table "places", force: :cascade do |t|
    t.string "google_place_id"
    t.string "name"
    t.string "timezone"
    t.float "longitude"
    t.float "latitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "city_id"
    t.integer "country_id"
  end

  create_table "slots", force: :cascade do |t|
    t.integer "dj_id"
    t.datetime "start_at", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "place_id"
    t.index ["dj_id"], name: "index_slots_on_dj_id"
  end

end
