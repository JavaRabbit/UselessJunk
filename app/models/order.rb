class Order < ActiveRecord::Base
  has_many :products, through: :order_items
  has_many :order_items
  
  # this is a comment :)
end
