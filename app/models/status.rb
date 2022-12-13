class Status < ApplicationRecord
  validates :status, :code, presence: true

  def to_s
    status
  end
end
