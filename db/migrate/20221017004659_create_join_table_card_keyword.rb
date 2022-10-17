class CreateJoinTableCardKeyword < ActiveRecord::Migration[7.0]
  def change
    create_join_table :Card, :Keyword do |t|
      # t.index [:card_id, :keyword_id]
      # t.index [:keyword_id, :card_id]
    end
  end
end
