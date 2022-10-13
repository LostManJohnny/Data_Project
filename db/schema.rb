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

ActiveRecord::Schema[7.0].define(version: 2022_10_13_161100) do
  create_table "artists", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "card_cardtypes", force: :cascade do |t|
    t.integer "card_id", null: false
    t.integer "cardtype_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["card_id"], name: "index_card_cardtypes_on_card_id"
    t.index ["cardtype_id"], name: "index_card_cardtypes_on_cardtype_id"
  end

  create_table "card_keywords", force: :cascade do |t|
    t.integer "card_id", null: false
    t.integer "keyword_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["card_id"], name: "index_card_keywords_on_card_id"
    t.index ["keyword_id"], name: "index_card_keywords_on_keyword_id"
  end

  create_table "card_printings", force: :cascade do |t|
    t.integer "cards_id", null: false
    t.integer "cardsets_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cards_id"], name: "index_card_printings_on_cards_id"
    t.index ["cardsets_id"], name: "index_card_printings_on_cardsets_id"
  end

  create_table "card_sets", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "card_subtypes", force: :cascade do |t|
    t.integer "card_id", null: false
    t.integer "subtype_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["card_id"], name: "index_card_subtypes_on_card_id"
    t.index ["subtype_id"], name: "index_card_subtypes_on_subtype_id"
  end

  create_table "card_supertypes", force: :cascade do |t|
    t.integer "card_id", null: false
    t.integer "supertype_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["card_id"], name: "index_card_supertypes_on_card_id"
    t.index ["supertype_id"], name: "index_card_supertypes_on_supertype_id"
  end

  create_table "cards", force: :cascade do |t|
    t.integer "artist_id", null: false
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
    t.integer "original_printing_id", null: false
    t.integer "power"
    t.integer "toughness"
    t.string "rarity"
    t.string "scryfallid"
    t.integer "card_set_id", null: false
    t.text "card_text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["artist_id"], name: "index_cards_on_artist_id"
    t.index ["card_set_id"], name: "index_cards_on_card_set_id"
    t.index ["original_printing_id"], name: "index_cards_on_original_printing_id"
  end

  create_table "cardtypes", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "keywords", force: :cascade do |t|
    t.string "keyword"
    t.text "effect"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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

  add_foreign_key "card_cardtypes", "cards"
  add_foreign_key "card_cardtypes", "cardtypes"
  add_foreign_key "card_keywords", "cards"
  add_foreign_key "card_keywords", "keywords"
  add_foreign_key "card_printings", "cards", column: "cards_id"
  add_foreign_key "card_printings", "cardsets", column: "cardsets_id"
  add_foreign_key "card_subtypes", "cards"
  add_foreign_key "card_subtypes", "subtypes"
  add_foreign_key "card_supertypes", "cards"
  add_foreign_key "card_supertypes", "supertypes"
  add_foreign_key "cards", "artists"
  add_foreign_key "cards", "card_sets"
  add_foreign_key "cards", "original_printings"
end
