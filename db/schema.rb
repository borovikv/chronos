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

ActiveRecord::Schema.define(version: 20160112082713) do

  create_table "boards", force: :cascade do |t|
    t.string   "name",       null: false
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "boards", ["user_id"], name: "index_boards_on_user_id"

  create_table "boards_users", id: false, force: :cascade do |t|
    t.integer "board_id", null: false
    t.integer "user_id",  null: false
  end

  add_index "boards_users", ["board_id", "user_id"], name: "index_boards_users_on_board_id_and_user_id"
  add_index "boards_users", ["user_id", "board_id"], name: "index_boards_users_on_user_id_and_board_id"

  create_table "cards", force: :cascade do |t|
    t.string   "title"
    t.text     "text"
    t.text     "html"
    t.integer  "group_id"
    t.datetime "due_date"
    t.datetime "start_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "order"
  end

  add_index "cards", ["group_id"], name: "index_cards_on_group_id"

  create_table "groups", force: :cascade do |t|
    t.string   "name"
    t.integer  "board_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "groups", ["board_id"], name: "index_groups_on_board_id"

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
