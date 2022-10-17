class Card < ApplicationRecord
  belongs_to :artist
  belongs_to :original_printing, class_name: "MyApplication::Business::Supplier"
  belongs_to :card_set

  has_many :keywords, through: :card_keywords
  has_many :subtypes, through: :card_subtypes
  has_many :supertypes, through: :card_supertypes

end
