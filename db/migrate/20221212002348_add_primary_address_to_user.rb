class AddPrimaryAddressToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :primary_address, :integer, null: true, foreign_key: {to_table: :addressses}
  end
end