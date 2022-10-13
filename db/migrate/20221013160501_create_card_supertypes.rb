class CreateCardSupertypes < ActiveRecord::Migration[7.0]
  def change
    create_table :card_supertypes do |t|
      t.references :card, null: false, foreign_key: true
      t.references :supertype, null: false, foreign_key: true

      t.timestamps
    end
  end
end
