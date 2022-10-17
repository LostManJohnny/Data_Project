class RenameCardsMagicSetToCardPrinting < ActiveRecord::Migration[7.0]
  def change
    rename_table :Card_MagicSet, :Card_Printing
  end
end
