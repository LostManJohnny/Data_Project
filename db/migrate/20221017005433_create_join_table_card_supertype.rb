class CreateJoinTableCardSupertype < ActiveRecord::Migration[7.0]
  def change
    create_join_table :Card, :Supertype do |t|
      # t.index [:card_id, :supertype_id]
      # t.index [:supertype_id, :card_id]
    end
  end
end
