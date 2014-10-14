class Product < ActiveRecord::Base
  has_many :order_items
  has_many :categories
  # relationships
end
