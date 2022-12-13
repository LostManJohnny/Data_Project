class Order < ApplicationRecord
  validates :user_id, :status_id, :shipping_address, presence: true

  belongs_to :user
  belongs_to :status

  has_many :order_items
end
