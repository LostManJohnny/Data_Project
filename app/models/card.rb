class Card < ApplicationRecord
  belongs_to :artist
  belongs_to :original_printing
  belongs_to :card_set
end
