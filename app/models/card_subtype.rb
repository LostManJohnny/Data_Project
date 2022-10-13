class CardSubtype < ApplicationRecord
  belongs_to :card
  belongs_to :subtype
end
