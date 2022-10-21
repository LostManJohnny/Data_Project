class Supertype < ApplicationRecord
  validates :name, presence: true, uniqueness: { case_sensitive: false }

  has_many :card_supertypes
  has_many :cards, through: :card_supertypes
end
