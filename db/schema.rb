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

ActiveRecord::Schema.define(version: 2023_05_03_102306) do

  create_table "member_requests", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "room_id", null: false
    t.bigint "appricant_id", null: false
    t.integer "status", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["appricant_id"], name: "fk_rails_34d0196034"
    t.index ["room_id"], name: "index_member_requests_on_room_id"
  end

  create_table "notifications", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "visitor_id", null: false
    t.integer "visited_id", null: false
    t.string "action", null: false
    t.bigint "member_request_id"
    t.bigint "restaurant_report_id"
    t.boolean "checked", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["member_request_id"], name: "index_notifications_on_member_request_id"
    t.index ["restaurant_report_id"], name: "index_notifications_on_restaurant_report_id"
  end

  create_table "restaurant_reports", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "title", null: false
    t.integer "score"
    t.string "content", null: false
    t.bigint "restaurant_id", null: false
    t.bigint "writer_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["restaurant_id"], name: "index_restaurant_reports_on_restaurant_id"
    t.index ["writer_id"], name: "fk_rails_044086b265"
  end

  create_table "restaurants", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "genre", null: false
    t.string "place", null: false
    t.string "holiday"
    t.string "url"
    t.string "tel"
    t.bigint "room_id", null: false
    t.bigint "last_editor_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.json "images"
    t.index ["last_editor_id"], name: "fk_rails_55a7bbfb48"
    t.index ["room_id"], name: "index_restaurants_on_room_id"
  end

  create_table "room_founders", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "founder_id", null: false
    t.bigint "room_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["founder_id"], name: "index_room_founders_on_founder_id"
    t.index ["room_id"], name: "index_room_founders_on_room_id"
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
    t.boolean "request_allowed", default: true
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["room_id"], name: "index_users_on_room_id"
  end

  add_foreign_key "member_requests", "rooms"
  add_foreign_key "member_requests", "users", column: "appricant_id"
  add_foreign_key "notifications", "member_requests"
  add_foreign_key "notifications", "restaurant_reports"
  add_foreign_key "restaurant_reports", "restaurants"
  add_foreign_key "restaurant_reports", "users", column: "writer_id"
  add_foreign_key "restaurants", "rooms"
  add_foreign_key "restaurants", "users", column: "last_editor_id"
  add_foreign_key "room_founders", "rooms"
  add_foreign_key "room_founders", "users", column: "founder_id"
  add_foreign_key "users", "rooms"
end
