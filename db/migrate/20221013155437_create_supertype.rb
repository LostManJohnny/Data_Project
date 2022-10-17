class CreateSupertype < ActiveRecord::Migration[7.0]
  def change
    create_table :supertype do |t|
      t.string :name

      t.timestamps
    end
  end
end
