class CreateJoinTableCardSubtype < ActiveRecord::Migration[7.0]
  def change
    create_join_table :Card, :Subtype do |t|
      # t.index [:card_id, :subtype_id]
      # t.index [:subtype_id, :card_id]
    end
  end
end
