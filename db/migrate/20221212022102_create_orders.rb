class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.datetime :complete_date
      t.references :status, null: false, foreign_key: true
      t.decimal :shipping_cost
      t.string :shipping_address

      t.timestamps
    end
  end
end
