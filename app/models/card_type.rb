class CardType < ApplicationRecord
  validates :type_id, :card_id, presence: true

  belongs_to :type
  belongs_to :card
end
