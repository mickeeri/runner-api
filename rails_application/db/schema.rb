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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160221103122) do

  create_table "race_tags", force: :cascade do |t|
    t.integer  "race_id"
    t.integer  "tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "race_tags", ["race_id", "tag_id"], name: "index_race_tags_on_race_id_and_tag_id", unique: true
  add_index "race_tags", ["race_id"], name: "index_race_tags_on_race_id"
  add_index "race_tags", ["tag_id"], name: "index_race_tags_on_tag_id"

end
