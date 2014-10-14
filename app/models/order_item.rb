class OrderItem < ActiveRecord::Base
  belongs_to :Product
  belongs_to :Order
end
