class CreateCardtypes < ActiveRecord::Migration[7.0]
  def change
    create_table :cardtypes do |t|
      t.string :name

      t.timestamps
    end
  end
end
