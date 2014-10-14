class User < ActiveRecord::Base
  has_many :products
  has_many :orderitems, through: :products

  validates :username, :email, presence: true, uniqueness: true
  validates :email, format: {with: /@/}
end
