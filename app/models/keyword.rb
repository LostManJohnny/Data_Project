class Keyword < ApplicationRecord
  validates :keyword, presence: true, uniqueness: { case_sensitive: false }
  validates :effect, uniqueness {case_sensitive: false }

  has_many :card_keywords
  has_many :cards, through: :card_keywords
end
