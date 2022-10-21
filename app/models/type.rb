class Type < ApplicationRecord
  validates :name, presence: true, uniqueness: { case_sensitive: false }

  has_many :card_types
  has_many :cards, through: :card_types
end
