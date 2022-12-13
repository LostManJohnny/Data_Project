class Province < ApplicationRecord
  validates :name, :code, :pst, :gst, :hst, presence: true

  has_many :users
end
