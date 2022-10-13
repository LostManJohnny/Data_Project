class AddReleaseDateToCardSets < ActiveRecord::Migration[7.0]
  def change
    add_column :card_sets, :release_date, :date
  end
end
