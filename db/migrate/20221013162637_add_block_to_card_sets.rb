class AddBlockToCardSets < ActiveRecord::Migration[7.0]
  def change
    add_column :card_sets, :block, :string
  end
end
