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

ActiveRecord::Schema[7.2].define(version: 2025_03_09_060628) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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

  create_table "characters", force: :cascade do |t|
    t.bigint "comic_id", null: false
    t.string "name", null: false
    t.text "description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["comic_id"], name: "index_characters_on_comic_id"
  end

  create_table "comics", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "title", null: false
    t.integer "total_page", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_comics_on_user_id"
  end

  create_table "panels", force: :cascade do |t|
    t.integer "position", null: false
    t.string "location", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "comic_id", null: false
    t.index ["comic_id"], name: "index_panels_on_comic_id"
  end

  create_table "speeches", force: :cascade do |t|
    t.bigint "panel_id", null: false
    t.bigint "character_id", null: false
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_speeches_on_character_id"
    t.index ["panel_id"], name: "index_speeches_on_panel_id"
  end

  create_table "stiky_notes", force: :cascade do |t|
    t.bigint "comic_id", null: false
    t.string "notable_type", null: false
    t.text "note_content"
    t.string "color", default: "yellow"
    t.float "position_x", default: 0.0, null: false
    t.float "position_y", default: 0.0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["comic_id"], name: "index_stiky_notes_on_comic_id"
  end

  create_table "story_maps", force: :cascade do |t|
    t.bigint "comic_id", null: false
    t.text "summary"
    t.text "description"
    t.text "main_charactter"
    t.text "likable_points"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["comic_id"], name: "index_story_maps_on_comic_id"
  end

  create_table "story_parts", force: :cascade do |t|
    t.bigint "comic_id", null: false
    t.string "content", null: false
    t.integer "part_type", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["comic_id"], name: "index_story_parts_on_comic_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "characters", "comics"
  add_foreign_key "comics", "users"
  add_foreign_key "panels", "comics"
  add_foreign_key "speeches", "characters"
  add_foreign_key "speeches", "panels"
  add_foreign_key "stiky_notes", "comics"
  add_foreign_key "story_maps", "comics"
  add_foreign_key "story_parts", "comics"
end
