class CreateCardPrintings < ActiveRecord::Migration[7.0]
  def change
    create_table :card_printings do |t|
      t.belongs_to :card, index: true
      t.belongs_to :magic_set, index: true

      t.timestamps
    end
  end
end
