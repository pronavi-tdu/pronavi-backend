# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_06_24_085208) do
  create_table "departments", primary_key: "department_id", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "department_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "schedules", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "user_id", null: false
    t.bigint "status_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["status_id"], name: "fk_rails_3ae427756a"
    t.index ["user_id"], name: "fk_rails_3c900465fa"
  end

  create_table "status_details", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "schedule_id", null: false
    t.string "description", default: ""
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["schedule_id"], name: "index_status_details_on_schedule_id"
  end

  create_table "status_locks", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "schedule_id", null: false
    t.boolean "lock_boolean", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["schedule_id"], name: "index_status_locks_on_schedule_id"
  end

  create_table "statuses", primary_key: "status_id", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "status_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", primary_key: "user_id", id: :string, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "user_name", null: false
    t.bigint "department_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "mailaddress"
    t.index ["department_id"], name: "fk_rails_f29bf9cdf2"
  end

  add_foreign_key "schedules", "statuses", primary_key: "status_id"
  add_foreign_key "schedules", "users", primary_key: "user_id"
  add_foreign_key "status_details", "schedules"
  add_foreign_key "status_locks", "schedules"
  add_foreign_key "users", "departments", primary_key: "department_id"
end
