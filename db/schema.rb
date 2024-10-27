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

ActiveRecord::Schema[7.0].define(version: 2024_10_08_121859) do
  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "ai_practices", force: :cascade do |t|
    t.integer "group_id"
    t.text "content"
    t.date "date_for"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_ai_practices_on_group_id"
  end

  create_table "daily_practice_items", force: :cascade do |t|
    t.integer "practice_id", null: false
    t.integer "daily_practice_id", null: false
    t.integer "training_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["daily_practice_id"], name: "index_daily_practice_items_on_daily_practice_id"
    t.index ["practice_id"], name: "index_daily_practice_items_on_practice_id"
  end

  create_table "daily_practices", force: :cascade do |t|
    t.integer "group_id", null: false
    t.integer "duration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_daily_practices_on_group_id"
  end

  create_table "group_users", force: :cascade do |t|
    t.integer "user_id"
    t.integer "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_group_users_on_group_id"
    t.index ["user_id"], name: "index_group_users_on_user_id"
  end

  create_table "groups", force: :cascade do |t|
    t.string "name"
    t.text "introduction"
    t.text "teams_behaviour"
    t.text "monthly_target"
    t.string "image_id"
    t.integer "owner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "invite_token"
    t.datetime "invite_token_expires_at"
  end

  create_table "messages", force: :cascade do |t|
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.integer "group_id"
    t.index ["group_id"], name: "index_messages_on_group_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "notes", force: :cascade do |t|
    t.string "title"
    t.text "good"
    t.text "bad"
    t.text "next"
    t.integer "user_id"
    t.integer "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "video_id"
    t.string "note_type"
    t.text "discuss"
    t.string "note_for"
    t.index ["group_id"], name: "index_notes_on_group_id"
    t.index ["user_id"], name: "index_notes_on_user_id"
    t.index ["video_id"], name: "index_notes_on_video_id"
  end

  create_table "practices", force: :cascade do |t|
    t.string "name"
    t.text "introduction"
    t.integer "number_of_people"
    t.text "issue"
    t.text "key_points"
    t.text "applicable_situation"
    t.integer "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "links"
    t.integer "user_id"
    t.index ["group_id"], name: "index_practices_on_group_id"
  end

  create_table "responses", force: :cascade do |t|
    t.string "section_type"
    t.text "input"
    t.text "response"
    t.integer "user_id"
    t.integer "group_id"
    t.integer "video_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "session_id"
    t.string "token"
    t.index ["group_id"], name: "index_responses_on_group_id"
    t.index ["user_id"], name: "index_responses_on_user_id"
    t.index ["video_id"], name: "index_responses_on_video_id"
  end

  create_table "sns_credentials", force: :cascade do |t|
    t.string "provider"
    t.string "uid"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sns_credentials_on_user_id"
  end

  create_table "summaries", force: :cascade do |t|
    t.integer "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "content"
    t.date "date_for"
    t.index ["group_id"], name: "index_summaries_on_group_id"
  end

  create_table "timestamps", force: :cascade do |t|
    t.integer "video_id"
    t.integer "time_s"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["video_id"], name: "index_timestamps_on_video_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "username"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "videos", force: :cascade do |t|
    t.string "title"
    t.text "introduction"
    t.integer "user_id"
    t.integer "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_videos_on_group_id"
    t.index ["user_id"], name: "index_videos_on_user_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "ai_practices", "groups"
  add_foreign_key "daily_practice_items", "daily_practices"
  add_foreign_key "daily_practice_items", "practices"
  add_foreign_key "daily_practices", "groups"
  add_foreign_key "group_users", "groups"
  add_foreign_key "group_users", "users"
  add_foreign_key "messages", "groups"
  add_foreign_key "messages", "users"
  add_foreign_key "notes", "groups"
  add_foreign_key "notes", "users"
  add_foreign_key "notes", "videos"
  add_foreign_key "practices", "groups"
  add_foreign_key "practices", "users", on_delete: :cascade
  add_foreign_key "responses", "groups"
  add_foreign_key "responses", "users"
  add_foreign_key "responses", "videos"
  add_foreign_key "sns_credentials", "users"
  add_foreign_key "summaries", "groups"
  add_foreign_key "timestamps", "videos"
  add_foreign_key "videos", "groups"
  add_foreign_key "videos", "users"
end
