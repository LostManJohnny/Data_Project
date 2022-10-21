class CardSubtype < ApplicationRecord
  validates :card_id, :subtype_id, presence: true

  belongs_to :card
  belongs_to :subtype
end
