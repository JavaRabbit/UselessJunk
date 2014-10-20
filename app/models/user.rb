class User < ActiveRecord::Base
  has_secure_password

  # no need to validate presence of password or password
  # confirmation, has_secure_password does that for you.
  # validate format of email, length of password, etc.

  validates :email, presence: true, uniqueness: true
  validates_uniqueness_of :email, format: {with: /@/}

  has_many :products
  has_many :orderitems, through: :products

end
