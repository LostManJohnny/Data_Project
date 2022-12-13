class Product < ApplicationRecord
  validates :card_id, :stock, :price, presence: true

  belongs_to :card

  has_many :order_items
end
