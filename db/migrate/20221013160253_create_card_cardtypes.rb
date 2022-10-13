class CreateCardCardtypes < ActiveRecord::Migration[7.0]
  def change
    create_table :card_cardtypes do |t|
      t.references :card, null: false, foreign_key: true
      t.references :cardtype, null: false, foreign_key: true

      t.timestamps
    end
  end
end
