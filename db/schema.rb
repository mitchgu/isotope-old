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

ActiveRecord::Schema.define(version: 20160620104009) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "login_tokens", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "series"
    t.string   "token_digest"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["user_id"], name: "index_login_tokens_on_user_id", using: :btree
  end

  create_table "user_tokens", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "type"
    t.string   "token_digest"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["user_id"], name: "index_user_tokens_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "first_name"
    t.string   "last_name"
    t.boolean  "activated",       default: false
  end

  add_foreign_key "user_tokens", "users"
end
