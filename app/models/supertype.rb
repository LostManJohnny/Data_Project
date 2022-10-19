class Supertype < ApplicationRecord
  has_many :card_supertypes
  has_many :cards, through: :card_supertypes
end
