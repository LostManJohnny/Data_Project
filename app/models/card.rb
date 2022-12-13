class Card < ApplicationRecord
  validates :name, presence: true, uniqueness: { case_sensitive: true }
  validates :scryfallid, :rarity, presence: true

  has_one_attached :image_uri

  belongs_to :artist
  belongs_to :magic_set
  belongs_to :original_printing, class_name: "MagicSet", foreign_key: "original_printing"

  has_one :product

  has_many :card_keywords
  has_many :card_subtypes
  has_many :card_supertypes
  has_many :card_types
  has_many :card_printings

  has_many :magic_sets, through: :card_printings
  has_many :keywords, through: :card_keywords
  has_many :subtypes, through: :card_subtypes
  has_many :supertypes, through: :card_supertypes
  has_many :types, through: :card_types
end
