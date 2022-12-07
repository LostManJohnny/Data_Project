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

ActiveRecord::Schema[7.0].define(version: 2022_12_06_202244) do
  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.integer "resource_id"
    t.string "author_type"
    t.integer "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource"
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

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "artists", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "card_keywords", force: :cascade do |t|
    t.integer "card_id"
    t.integer "keyword_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["card_id"], name: "index_card_keywords_on_card_id"
    t.index ["keyword_id"], name: "index_card_keywords_on_keyword_id"
  end

  create_table "card_printings", force: :cascade do |t|
    t.integer "card_id"
    t.integer "magic_set_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["card_id"], name: "index_card_printings_on_card_id"
    t.index ["magic_set_id"], name: "index_card_printings_on_magic_set_id"
  end

  create_table "card_subtypes", force: :cascade do |t|
    t.integer "card_id"
    t.integer "subtype_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["card_id"], name: "index_card_subtypes_on_card_id"
    t.index ["subtype_id"], name: "index_card_subtypes_on_subtype_id"
  end

  create_table "card_supertypes", force: :cascade do |t|
    t.integer "card_id"
    t.integer "supertype_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["card_id"], name: "index_card_supertypes_on_card_id"
    t.index ["supertype_id"], name: "index_card_supertypes_on_supertype_id"
  end

  create_table "card_types", force: :cascade do |t|
    t.integer "type_id"
    t.integer "card_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["card_id"], name: "index_card_types_on_card_id"
    t.index ["type_id"], name: "index_card_types_on_type_id"
  end

  create_table "cards", force: :cascade do |t|
    t.integer "artist_id"
    t.string "ascii_name"
    t.string "border_color"
    t.string "color_identity"
    t.string "colors"
    t.integer "cmc"
    t.string "finishes"
    t.string "flavor_name"
    t.text "flavor_text"
    t.boolean "has_foil"
    t.boolean "is_alternative"
    t.boolean "is_fullart"
    t.boolean "is_oversized"
    t.boolean "is_promo"
    t.boolean "is_reprint"
    t.boolean "is_reserved"
    t.string "layout"
    t.integer "life"
    t.integer "loyalty"
    t.string "mana_cost"
    t.string "name"
    t.integer "original_printing", null: false
    t.string "power"
    t.string "toughness"
    t.string "rarity"
    t.string "scryfallid"
    t.integer "magic_set_id", null: false
    t.text "card_text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["artist_id"], name: "index_cards_on_artist_id"
    t.index ["magic_set_id"], name: "index_cards_on_magic_set_id"
  end

  create_table "keywords", force: :cascade do |t|
    t.string "keyword"
    t.text "effect"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "magic_sets", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.string "block"
    t.date "release_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.integer "card_id", null: false
    t.integer "stock"
    t.decimal "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["card_id"], name: "index_products_on_card_id"
  end

  create_table "subtypes", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "supertypes", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "cards", "artists"
  add_foreign_key "cards", "magic_sets"
  add_foreign_key "products", "cards"
end
