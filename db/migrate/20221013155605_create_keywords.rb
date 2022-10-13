class CreateKeywords < ActiveRecord::Migration[7.0]
  def change
    create_table :keywords do |t|
      t.string :keyword
      t.text :effect

      t.timestamps
    end
  end
end
