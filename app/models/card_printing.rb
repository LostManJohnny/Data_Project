class CardPrinting < ApplicationRecord
  validates :card_id, :magic_set_id, presence: true

  belongs_to :card
  belongs_to :magic_set
end
