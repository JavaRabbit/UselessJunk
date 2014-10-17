class User < ActiveRecord::Base
  has_secure_password
  attr_accessor :password

  has_many :products
  has_many :orderitems, through: :products

  EMAIL_REGEX = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i
  validates :username, :email, presence: true, uniqueness: true
  validates :email, format: {with: /@/}

end
