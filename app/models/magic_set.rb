class MagicSet < ApplicationRecord
  validates :code, :name, presence: true, uniqueness: { case_sensitive: false }

  has_many :cards
end
