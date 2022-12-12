class Address < ApplicationRecord
  belongs_to :country
  belongs_to :province

  has_one :user

  def to_s
    addr = ""

    if !unit_number.blank?
      addr = unit_number.to_s + "-"
    end

    addr = addr + street_number.to_s + " " + street_name + "\n"
    addr = addr + city + ", " + Province.find(province_id).name + "\n"
    addr = addr + postal_code + "\n"
    addr = addr + Country.find(country_id).name

    return addr
  end
end
