class CreateJoinTableCardPrinting < ActiveRecord::Migration[7.0]
  def change
    create_join_table :Card, :MagicSet do |t|
      # t.index [:card_id, :magic_set_id]
      # t.index [:magic_set_id, :card_id]
    end
  end
end
