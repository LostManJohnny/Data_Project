class CreateCards < ActiveRecord::Migration[7.0]
  def change
    create_table :cards do |t|
      t.references :artist, null: false, foreign_key: true
      t.string :ascii_name
      t.string :border_color
      t.string :color_identity
      t.string :colors
      t.integer :cmc
      t.string :finishes
      t.string :flavor_name
      t.text :flavor_text
      t.boolean :has_foil
      t.boolean :is_alternative
      t.boolean :is_fullart
      t.boolean :is_oversized
      t.boolean :is_promo
      t.boolean :is_reprint
      t.boolean :is_reserved
      t.string :layout
      t.integer :life
      t.integer :loyalty
      t.string :mana_cost
      t.string :name
      t.references :original_printing, null: false, foreign_key: true
      t.integer :power
      t.integer :toughness
      t.string :rarity
      t.string :scryfallid
      t.references :card_set, null: false, foreign_key: true
      t.text :card_text

      t.timestamps
    end
  end
end
