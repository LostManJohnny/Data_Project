class User < ApplicationRecord
  validates :email, :encrypted_password, :username, :province_id, presence: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :addressses
  has_many :orders

  has_one :province
end
