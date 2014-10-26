class Product < ActiveRecord::Base
  belongs_to :user
  has_many :order_items
  has_and_belongs_to_many :categories
  has_many :reviews
  # relationships

  validates :name, :description, :price, :quantity, :user_id, presence: true
  validates :quantity, numericality: {greater_than: -1}

end
