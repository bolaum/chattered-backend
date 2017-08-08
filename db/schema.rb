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

ActiveRecord::Schema.define(version: 20170807135820) do

  create_table "channel_joins", force: :cascade do |t|
    t.integer "nick_id", null: false
    t.integer "channel_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["channel_id"], name: "index_channel_joins_on_channel_id"
    t.index ["nick_id", "channel_id"], name: "index_channel_joins_on_nick_id_and_channel_id", unique: true
    t.index ["nick_id"], name: "index_channel_joins_on_nick_id"
  end

  create_table "channels", force: :cascade do |t|
    t.string "title", null: false
    t.integer "owner_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_channels_on_owner_id"
    t.index ["title"], name: "index_channels_on_title", unique: true
  end

  create_table "messages", force: :cascade do |t|
    t.text "content", null: false
    t.datetime "sent_at", null: false
    t.integer "nick_id", null: false
    t.integer "channel_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["channel_id"], name: "index_messages_on_channel_id"
    t.index ["nick_id"], name: "index_messages_on_nick_id"
  end

  create_table "nicks", force: :cascade do |t|
    t.string "name", null: false
    t.string "token_digest", null: false
    t.string "status", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_nicks_on_name", unique: true
  end

end
