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

ActiveRecord::Schema[7.2].define(version: 2024_10_27_040730) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "advertisements", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.float "price"
    t.integer "status"
    t.integer "category"
    t.integer "campus"
    t.string "phone_contact"
    t.string "email_contact"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "user_id", null: false
    t.index ["user_id"], name: "index_advertisements_on_user_id"
  end

  create_table "messages", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.text "text"
    t.boolean "edited"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "user_id", null: false
    t.uuid "advertisement_id", null: false
    t.index ["advertisement_id"], name: "index_messages_on_advertisement_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "reviews", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.float "rating"
    t.text "comments"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "user_id", null: false
    t.uuid "transaction_id", null: false
    t.index ["transaction_id"], name: "index_reviews_on_transaction_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "transactions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "user_id", null: false
    t.uuid "advertisement_id", null: false
    t.index ["advertisement_id"], name: "index_transactions_on_advertisement_id"
    t.index ["user_id"], name: "index_transactions_on_user_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "image"
    t.string "full_name"
    t.string "cpf"
    t.string "email"
    t.string "password_digest"
    t.integer "role"
    t.string "university"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "advertisements", "users"
  add_foreign_key "messages", "advertisements"
  add_foreign_key "messages", "users"
  add_foreign_key "reviews", "transactions"
  add_foreign_key "reviews", "users"
  add_foreign_key "transactions", "advertisements"
  add_foreign_key "transactions", "users"
end
