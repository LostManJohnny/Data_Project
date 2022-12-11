class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.references :country, null: false, foreign_key: true
      t.references :province, null: false, foreign_key: true
      t.string :street_name
      t.integer :street_number
      t.integer :unit_number
      t.string :city
      t.string :postal_code

      t.timestamps
    end
  end
end
