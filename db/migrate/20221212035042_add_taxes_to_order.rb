class AddTaxesToOrder < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :taxes, :decimal, default: 0, null: false
  end
end
