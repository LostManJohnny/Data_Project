class CreateSubtype < ActiveRecord::Migration[7.0]
  def change
    create_table :subtype do |t|
      t.string :name

      t.timestamps
    end
  end
end
