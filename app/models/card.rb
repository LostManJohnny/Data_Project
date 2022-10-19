class Card < ApplicationRecord
  belongs_to :artist
  belongs_to :magic_set

  has_many :card_keywords
  has_many :card_subtypes
  has_many :card_supertypes
  has_many :card_types

  has_many :keywords, through: :card_keywords
  has_many :subtypes, through: :card_subtypes
  has_many :supertypes, through: :card_supertypes
  has_many :types, through: :card_types
end
