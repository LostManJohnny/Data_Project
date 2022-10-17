class Keyword < ApplicationRecord
  belongs_to :card, through: :card_keywords
  belongs_to :keywords, through: :card_keywords
end
