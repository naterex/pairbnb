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

ActiveRecord::Schema.define(version: 20160229042622) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authentications", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "uid"
    t.string   "token"
    t.string   "provider"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "authentications", ["provider"], name: "index_authentications_on_provider", using: :btree
  add_index "authentications", ["token"], name: "index_authentications_on_token", using: :btree
  add_index "authentications", ["uid"], name: "index_authentications_on_uid", using: :btree
  add_index "authentications", ["user_id"], name: "index_authentications_on_user_id", using: :btree

  create_table "booked_dates", force: :cascade do |t|
    t.integer  "reservation_id"
    t.integer  "listing_id"
    t.date     "date"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "booked_dates", ["date"], name: "index_booked_dates_on_date", using: :btree
  add_index "booked_dates", ["listing_id"], name: "index_booked_dates_on_listing_id", using: :btree
  add_index "booked_dates", ["reservation_id"], name: "index_booked_dates_on_reservation_id", using: :btree

  create_table "listings", force: :cascade do |t|
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "user_id"
    t.string   "title"
    t.text     "about"
    t.string   "property_type"
    t.string   "room_type"
    t.integer  "bedrooms"
    t.integer  "bathrooms"
    t.integer  "guests"
    t.integer  "price"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "country"
    t.json     "photos"
  end

  add_index "listings", ["about"], name: "index_listings_on_about", using: :btree
  add_index "listings", ["address"], name: "index_listings_on_address", using: :btree
  add_index "listings", ["bathrooms"], name: "index_listings_on_bathrooms", using: :btree
  add_index "listings", ["bedrooms"], name: "index_listings_on_bedrooms", using: :btree
  add_index "listings", ["city"], name: "index_listings_on_city", using: :btree
  add_index "listings", ["country"], name: "index_listings_on_country", using: :btree
  add_index "listings", ["guests"], name: "index_listings_on_guests", using: :btree
  add_index "listings", ["price"], name: "index_listings_on_price", using: :btree
  add_index "listings", ["property_type"], name: "index_listings_on_property_type", using: :btree
  add_index "listings", ["room_type"], name: "index_listings_on_room_type", using: :btree
  add_index "listings", ["state"], name: "index_listings_on_state", using: :btree
  add_index "listings", ["title"], name: "index_listings_on_title", using: :btree
  add_index "listings", ["user_id"], name: "index_listings_on_user_id", using: :btree

  create_table "reservations", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "listing_id"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "reservations", ["end_date"], name: "index_reservations_on_end_date", using: :btree
  add_index "reservations", ["listing_id"], name: "index_reservations_on_listing_id", using: :btree
  add_index "reservations", ["start_date"], name: "index_reservations_on_start_date", using: :btree
  add_index "reservations", ["user_id"], name: "index_reservations_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "encrypted_password", limit: 128
    t.string   "confirmation_token", limit: 128
    t.string   "remember_token",     limit: 128, null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["first_name"], name: "index_users_on_first_name", using: :btree
  add_index "users", ["last_name"], name: "index_users_on_last_name", using: :btree
  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree

end
