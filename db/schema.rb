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

ActiveRecord::Schema.define(version: 20150823135646) do

  create_table "lists", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.string   "name",       limit: 20
    t.string   "category",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "background", limit: 255, default: "1"
  end

  add_index "lists", ["user_id"], name: "index_lists_on_user_id", using: :btree

  create_table "movie_lists", force: :cascade do |t|
    t.integer  "list_id",    limit: 4
    t.integer  "movie_id",   limit: 4
    t.string   "comment",    limit: 255
    t.integer  "rating",     limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "movie_lists", ["list_id", "movie_id"], name: "index_movie_lists_on_list_id_and_movie_id", using: :btree

  create_table "movies", force: :cascade do |t|
    t.string   "title",             limit: 255
    t.string   "poster",            limit: 255
    t.string   "runtime",           limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "release_date"
    t.string   "tmdb_id",           limit: 255
    t.string   "imdb_id",           limit: 255
    t.string   "overview",          limit: 1000
    t.string   "original_language", limit: 255
    t.string   "poster_p",          limit: 255
    t.string   "tagline",           limit: 255
    t.float    "vote_avarage",      limit: 24
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "username",               limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
