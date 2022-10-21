class CardKeyword < ApplicationRecord
  validates :card_id, :keyword_id, presence: true

  belongs_to :card
  belongs_to :keyword
end
