class CreateCardSets < ActiveRecord::Migration[7.0]
  def change
    create_table :magic_set do |t|
      t.string :code
      t.string :name
      t.string :block
      t.date  :release_date

      t.timestamps
    end
  end
end
