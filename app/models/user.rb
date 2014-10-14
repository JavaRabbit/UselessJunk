class User < ActiveRecord::Base
  has_many :products
  has_many :orderitems, through: :products
end
