class CreateSubtypes < ActiveRecord::Migration[7.0]
  def change
    create_table :subtypes do |t|
      t.string :name

      t.timestamps
    end
  end
end
