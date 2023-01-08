# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2023_01_08_141431) do

  create_table "member_requests", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "room_id"
    t.bigint "appricant_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["appricant_id"], name: "fk_rails_34d0196034"
    t.index ["room_id"], name: "index_member_requests_on_room_id"
  end

  create_table "notifications", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "visitor_id"
    t.integer "visited_id"
    t.integer "comment_id"
    t.string "action"
    t.boolean "checked", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "room_comments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "content", null: false
    t.bigint "room_report_restaurants_id"
    t.bigint "users_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["room_report_restaurants_id"], name: "index_room_comments_on_room_report_restaurants_id"
    t.index ["users_id"], name: "index_room_comments_on_users_id"
  end

  create_table "room_fund_restaurants", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "genre", null: false
    t.string "place", null: false
    t.string "holiday"
    t.string "url"
    t.bigint "tel"
    t.bigint "room_id"
    t.bigint "last_editor_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["last_editor_id"], name: "fk_rails_3f4c21423c"
    t.index ["room_id"], name: "index_room_fund_restaurants_on_room_id"
  end

  create_table "room_report_restaurants", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "title", null: false
    t.integer "score", null: false
    t.string "content", null: false
    t.bigint "room_fund_restaurants_id"
    t.bigint "users_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["room_fund_restaurants_id"], name: "index_room_report_restaurants_on_room_fund_restaurants_id"
    t.index ["users_id"], name: "index_room_report_restaurants_on_users_id"
  end

  create_table "rooms", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "token"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["token"], name: "index_rooms_on_token", unique: true
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "room_id"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "is_founder", default: false
    t.boolean "request_allowed", default: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["room_id"], name: "index_users_on_room_id"
  end

  add_foreign_key "member_requests", "rooms"
  add_foreign_key "member_requests", "users", column: "appricant_id"
  add_foreign_key "room_comments", "room_report_restaurants", column: "room_report_restaurants_id"
  add_foreign_key "room_comments", "users", column: "users_id"
  add_foreign_key "room_fund_restaurants", "rooms"
  add_foreign_key "room_fund_restaurants", "users", column: "last_editor_id"
  add_foreign_key "room_report_restaurants", "room_fund_restaurants", column: "room_fund_restaurants_id"
  add_foreign_key "room_report_restaurants", "users", column: "users_id"
  add_foreign_key "users", "rooms"
end
