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

ActiveRecord::Schema[7.0].define(version: 2023_01_18_085912) do
  create_table "active_storage_attachments", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.string "record_type", limit: 255, null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "key", limit: 255, null: false
    t.string "filename", limit: 255, null: false
    t.string "content_type", limit: 255
    t.text "metadata"
    t.string "service_name", limit: 255, null: false
    t.bigint "byte_size", null: false
    t.string "checksum", limit: 255
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", limit: 255, null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "brands", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.bigint "company_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_brands_on_company_id"
  end

  create_table "campaign_participations", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "campaign_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["campaign_id", "user_id"], name: "index_campaign_participations_on_campaign_id_and_user_id", unique: true
    t.index ["campaign_id"], name: "index_campaign_participations_on_campaign_id"
    t.index ["user_id"], name: "index_campaign_participations_on_user_id"
  end

  create_table "campaigns", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.string "name", limit: 255, null: false
    t.datetime "posted_period", null: false
    t.float "play_unit_price", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_campaigns_on_product_id"
  end

  create_table "companies", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "participation_tiktok_movies", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "tiktok_movie_id", null: false
    t.bigint "campaign_participation_id", null: false
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["campaign_participation_id"], name: "index_participation_tiktok_movies_on_campaign_participation_id"
    t.index ["tiktok_movie_id", "campaign_participation_id"], name: "ptm_tm_cp_unique_index"
    t.index ["tiktok_movie_id"], name: "index_participation_tiktok_movies_on_tiktok_movie_id"
  end

  create_table "products", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "brand_id", null: false
    t.string "name", limit: 255, null: false
    t.text "description", null: false
    t.integer "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["brand_id"], name: "index_products_on_brand_id"
  end

  create_table "reference_tiktok_movies", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.text "embed_url", null: false
    t.bigint "product_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_reference_tiktok_movies_on_product_id"
  end

  create_table "tiktok_access_tokens", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.text "access_token", null: false
    t.string "scope", limit: 255, null: false
    t.string "log_id", limit: 255, null: false
    t.string "open_id", limit: 255, null: false
    t.text "refresh_token", null: false
    t.integer "expires_in", null: false
    t.integer "refresh_expires_in", null: false
    t.integer "error_code", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_tiktok_access_tokens_on_user_id"
  end

  create_table "tiktok_movie_logs", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "tiktok_movie_id", null: false
    t.integer "like_count", null: false
    t.integer "comment_count", null: false
    t.integer "share_count", null: false
    t.integer "view_count", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tiktok_movie_id"], name: "index_tiktok_movie_logs_on_tiktok_movie_id"
  end

  create_table "tiktok_movie_profiles", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "tiktok_movie_id", null: false
    t.datetime "posted_at", null: false
    t.string "uid", limit: 255, null: false
    t.string "cover_image_url", limit: 255
    t.text "share_url", null: false
    t.text "video_description"
    t.integer "duration"
    t.integer "height"
    t.integer "width"
    t.text "title"
    t.text "embed_html"
    t.text "embed_link"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tiktok_movie_id"], name: "index_tiktok_movie_profiles_on_tiktok_movie_id"
  end

  create_table "tiktok_movies", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.text "tiktok_uid", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_tiktok_movies_on_user_id"
  end

  create_table "transfer_requests", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "amount", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_transfer_requests_on_user_id"
  end

  create_table "user_profiles", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "tiktok_user_name", limit: 255
    t.text "tiktok_user_image_url"
    t.string "tiktok_open_id", limit: 255
    t.string "tiktok_union_id", limit: 255
    t.text "tiktok_profile_deep_link"
    t.string "line_user_id", limit: 255
    t.string "line_user_name", limit: 255
    t.string "line_user_image_url", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_profiles_on_user_id"
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "provider", limit: 255, default: "email", null: false
    t.string "uid", limit: 255, default: "", null: false
    t.string "encrypted_password", limit: 255, default: "", null: false
    t.string "reset_password_token", limit: 255
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at"
    t.string "confirmation_token", limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email", limit: 255
    t.string "email", limit: 255
    t.text "tokens"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "brands", "companies"
  add_foreign_key "campaign_participations", "campaigns"
  add_foreign_key "campaign_participations", "users"
  add_foreign_key "campaigns", "products"
  add_foreign_key "participation_tiktok_movies", "campaign_participations"
  add_foreign_key "participation_tiktok_movies", "tiktok_movies"
  add_foreign_key "products", "brands"
  add_foreign_key "reference_tiktok_movies", "products"
  add_foreign_key "tiktok_access_tokens", "users"
  add_foreign_key "tiktok_movie_logs", "tiktok_movies"
  add_foreign_key "tiktok_movie_profiles", "tiktok_movies"
  add_foreign_key "tiktok_movies", "users"
  add_foreign_key "transfer_requests", "users"
  add_foreign_key "user_profiles", "users"
end
