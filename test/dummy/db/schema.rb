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

ActiveRecord::Schema.define(version: 20131027190535) do

  create_table "content_blocks", force: true do |t|
    t.integer  "parent_id"
    t.string   "parent_type"
    t.string   "block_type"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "content_blocks", ["parent_type", "parent_id", "block_type"], name: "index_content_blocks_on_many_fields"

  create_table "images", force: true do |t|
    t.string   "attachment"
    t.integer  "parent_id"
    t.string   "parent_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "relationship_name"
    t.text     "caption"
  end

  add_index "images", ["parent_id", "parent_type"], name: "index_images_on_parent_id_and_parent_type"

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "username"
    t.string   "email"
    t.string   "password_digest"
    t.boolean  "is_admin",        default: false
    t.boolean  "is_sysop",        default: false
    t.boolean  "active",          default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
