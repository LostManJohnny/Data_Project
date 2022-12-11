class Address < ApplicationRecord
  belongs_to :country
  belongs_to :province

  has_many :user_addresses

  has_many :users, through: :user_addresses
end
