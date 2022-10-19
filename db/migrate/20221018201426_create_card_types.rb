class CreateCardTypes < ActiveRecord::Migration[7.0]
  def change
    create_table :card_types do |t|
      t.belongs_to :type, index: true
      t.belongs_to :card, index: true

      t.timestamps
    end
  end
end
