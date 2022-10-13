class CardPrinting < ApplicationRecord
  belongs_to :cards
  belongs_to :cardsets
end
