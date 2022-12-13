class Address < ApplicationRecord
  validates :country_id, :province_id, :street_name, :street_number, :city, :postal_code, :user_id, presence: true

  belongs_to :country
  belongs_to :province

  has_one :user

  def to_s
    addr = ""

    addr = "#{unit_number}-" if unit_number.present?

    addr = "#{addr}#{street_number} #{street_name}\n"
    addr = "#{addr}#{city}, #{Province.find(province_id).name}\n"
    addr = "#{addr}#{postal_code}\n"
    addr += Country.find(country_id).name

    addr
  end
end
