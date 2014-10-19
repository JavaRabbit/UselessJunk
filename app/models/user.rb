class User < ActiveRecord::Base
  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates_uniqueness_of :email, format: {with: /@/}

  has_many :products
  has_many :orderitems, through: :products

end
