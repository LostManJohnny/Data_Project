class CreateCardPrintings < ActiveRecord::Migration[7.0]
  def change
    create_table :card_printings do |t|
      t.references :cards, null: false, foreign_key: true
      t.references :cardsets, null: false, foreign_key: true

      t.timestamps
    end
  end
end
