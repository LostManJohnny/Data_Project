class CardType < ApplicationRecord
  belongs_to :type
  belongs_to :card
end
