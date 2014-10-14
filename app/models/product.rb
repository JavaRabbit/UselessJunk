class Product < ActiveRecord::Base
  belongs_to :users
  has_many :order_items
  has_many :categories
  # relationships
end
