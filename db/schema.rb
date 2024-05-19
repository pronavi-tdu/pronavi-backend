ActiveRecord::Schema[7.1].define(version: 2024_05_16_014310) do
  create_table "schedules", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "user_id", null: false
    t.bigint "status_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["status_id"], name: "fk_rails_3ae427756a"
    t.index ["user_id"], name: "fk_rails_3c900465fa"
  end

  create_table "statuses", primary_key: "status_id", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "status_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", primary_key: "user_id", id: :string, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "password", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "schedules", "statuses", primary_key: "status_id"
  add_foreign_key "schedules", "users", primary_key: "user_id"
end
