class Keyword < ApplicationRecord
  has_many :card_keywords
  has_many :cards, through: :card_keywords
end
