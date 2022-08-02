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

ActiveRecord::Schema[7.0].define(version: 2022_08_01_203053) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "creatives", force: :cascade do |t|
    t.string "creative_id", null: false
    t.float "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["creative_id"], name: "index_creatives_on_creative_id", unique: true
  end

  create_table "placements", force: :cascade do |t|
    t.string "placement_id", null: false
    t.float "floor_price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["placement_id"], name: "index_placements_on_placement_id", unique: true
  end

end
