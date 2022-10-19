class CreateCardKeywords < ActiveRecord::Migration[7.0]
  def change
    create_table :card_keywords do |t|
      t.belongs_to :card, index: true
      t.belongs_to :keyword, index: true

      t.timestamps
    end
  end
end
