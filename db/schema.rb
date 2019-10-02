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

ActiveRecord::Schema.define(version: 2019_10_01_121122) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "divisions", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "tournament_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tournament_id"], name: "index_divisions_on_tournament_id"
  end

  create_table "matches", force: :cascade do |t|
    t.integer "first_team_id"
    t.integer "second_team_id"
    t.integer "winning_team_id"
    t.integer "parent_id", null: false
    t.string "parent_type", null: false
    t.integer "sub_match_id"
    t.integer "round"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "playoffs", force: :cascade do |t|
    t.bigint "tournament_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tournament_id"], name: "index_playoffs_on_tournament_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "division_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["division_id"], name: "index_teams_on_division_id"
  end

  create_table "tournaments", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "divisions", "tournaments"
  add_foreign_key "playoffs", "tournaments"
  add_foreign_key "teams", "divisions"
end
