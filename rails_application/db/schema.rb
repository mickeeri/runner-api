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

ActiveRecord::Schema.define(version: 20160222212112) do

  create_table "locations", force: :cascade do |t|
    t.string   "city"
    t.float    "longitude"
    t.float    "latitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "locations", ["city"], name: "index_locations_on_city"

  create_table "races", force: :cascade do |t|
    t.string   "name"
    t.date     "date"
    t.string   "organiser"
    t.string   "web_site"
    t.float    "distance"
    t.integer  "location_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "resource_owner_id"
  end

  add_index "races", ["location_id"], name: "index_races_on_location_id"
  add_index "races", ["name"], name: "index_races_on_name"
  add_index "races", ["resource_owner_id"], name: "index_races_on_resource_owner_id"

  create_table "resource_owners", force: :cascade do |t|
    t.string   "access_token"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "screenname"
    t.string   "email"
    t.string   "password_digest"
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", force: :cascade do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true

  create_table "user_applications", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "api_key"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "user_applications", ["api_key"], name: "index_user_applications_on_api_key"
  add_index "user_applications", ["user_id"], name: "index_user_applications_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "password_digest"
    t.boolean  "admin",           default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

end
