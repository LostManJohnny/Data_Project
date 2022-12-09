class CreateProvinces < ActiveRecord::Migration[7.0]
  def change
    create_table :provinces do |t|
      t.string :name
      t.string :code
      t.decimal :pst
      t.decimal :hst
      t.decimal :gst

      t.timestamps
    end
  end
end
