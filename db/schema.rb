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

ActiveRecord::Schema.define(version: 20140326095050) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "about_me_contents", force: true do |t|
    t.string   "header"
    t.text     "description"
    t.string   "button_title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "background_image_file_name"
    t.string   "background_image_content_type"
    t.integer  "background_image_file_size"
    t.datetime "background_image_updated_at"
  end

  create_table "contacts", force: true do |t|
    t.string   "email"
    t.string   "vimeo_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "background_image_file_name"
    t.string   "background_image_content_type"
    t.integer  "background_image_file_size"
    t.datetime "background_image_updated_at"
    t.string   "facebook"
  end

  create_table "current_projects", force: true do |t|
    t.string   "header"
    t.text     "description"
    t.integer  "progress"
    t.string   "media_link"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "media_image_file_name"
    t.string   "media_image_content_type"
    t.integer  "media_image_file_size"
    t.datetime "media_image_updated_at"
    t.string   "media_choice"
    t.integer  "grid_row"
    t.integer  "grid_column"
    t.integer  "grid_sizex"
    t.integer  "grid_sizey"
    t.string   "grid_tile_image_file_name"
    t.string   "grid_tile_image_content_type"
    t.integer  "grid_tile_image_file_size"
    t.datetime "grid_tile_image_updated_at"
  end

  create_table "grid_positions", force: true do |t|
    t.string   "parent_name"
    t.text     "serialized_array"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "showreels", force: true do |t|
    t.string   "media_link"
    t.string   "header"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "media_choice"
    t.string   "media_image_file_name"
    t.string   "media_image_content_type"
    t.integer  "media_image_file_size"
    t.datetime "media_image_updated_at"
    t.string   "background_image_file_name"
    t.string   "background_image_content_type"
    t.integer  "background_image_file_size"
    t.datetime "background_image_updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "works", force: true do |t|
    t.string   "media_link"
    t.string   "header"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "media_choice"
    t.string   "media_image_file_name"
    t.string   "media_image_content_type"
    t.integer  "media_image_file_size"
    t.datetime "media_image_updated_at"
    t.integer  "grid_row"
    t.integer  "grid_column"
    t.integer  "grid_sizex"
    t.integer  "grid_sizey"
    t.string   "grid_tile_image_file_name"
    t.string   "grid_tile_image_content_type"
    t.integer  "grid_tile_image_file_size"
    t.datetime "grid_tile_image_updated_at"
  end

end
