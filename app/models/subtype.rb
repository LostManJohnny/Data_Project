class Subtype < ApplicationRecord
  validates :name, presence: true, uniqueness: { case_sensitive: false }

  has_many :card_subtypes
  has_many :cards, through: :card_subtypes
end
