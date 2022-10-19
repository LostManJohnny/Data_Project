class CreateCardSubtypes < ActiveRecord::Migration[7.0]
  def change
    create_table :card_subtypes do |t|
      t.belongs_to :card, index: true
      t.belongs_to :subtype, index: true

      t.timestamps
    end
  end
end
