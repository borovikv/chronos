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

ActiveRecord::Schema.define(version: 20160121074953) do

  create_table "boards", force: :cascade do |t|
    t.string   "name",       null: false
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "boards", ["user_id"], name: "index_boards_on_user_id"

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

  create_table "comment_hierarchies", id: false, force: :cascade do |t|
    t.integer "ancestor_id",   null: false
    t.integer "descendant_id", null: false
    t.integer "generations",   null: false
  end

  add_index "comment_hierarchies", ["ancestor_id", "descendant_id", "generations"], name: "comment_anc_desc_udx", unique: true
  add_index "comment_hierarchies", ["descendant_id"], name: "comment_desc_idx"

  create_table "comments", force: :cascade do |t|
    t.string   "title"
    t.integer  "user_id"
    t.text     "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "card_id"
    t.integer  "parent_id"
  end

  add_index "comments", ["card_id"], name: "index_comments_on_card_id"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "edges", force: :cascade do |t|
    t.integer  "card_a_id",  null: false
    t.integer  "card_b_id",  null: false
    t.integer  "relation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "groups", force: :cascade do |t|
    t.string   "name"
    t.integer  "board_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "groups", ["board_id"], name: "index_groups_on_board_id"

  create_table "permissions", force: :cascade do |t|
    t.integer  "board_id"
    t.integer  "user_id"
    t.integer  "permission"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "permissions", ["board_id"], name: "index_permissions_on_board_id"
  add_index "permissions", ["user_id"], name: "index_permissions_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
