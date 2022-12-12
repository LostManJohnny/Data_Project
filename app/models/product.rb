class Product < ApplicationRecord
  belongs_to :card

  has_many :order_items
end
