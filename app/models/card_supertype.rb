class CardSupertype < ApplicationRecord
  validates :card_id, :supertype_id, presence: true

  belongs_to :card
  belongs_to :supertype
end
