class CreateCardSupertypes < ActiveRecord::Migration[7.0]
  def change
    create_table :card_supertypes do |t|
      t.belongs_to :card, index: true
      t.belongs_to :supertype, index: true

      t.timestamps
    end
  end
end
