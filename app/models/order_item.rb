class OrderItem < ApplicationRecord
  validates :order_id, :quantity, :unit_price, :product_id, presence: true

  belongs_to :order
  belongs_to :product
end
