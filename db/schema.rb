ActiveRecord::Schema.define(version: 2020_06_12_124920) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "estimations", force: :cascade do |t|
    t.integer "value"
    t.integer "post_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", force: :cascade do |t|
    t.string "title"
    t.text "text"
    t.text "ip_address"
    t.integer "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string "login"
    t.datetime "created_at"
    t.datetime "updated_at"
  end
end
