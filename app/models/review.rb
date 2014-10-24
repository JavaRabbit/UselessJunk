class Review < ActiveRecord::Base
  belongs_to :product

  validates :title, :content, :product_id, :rating, presence: true
  validates :rating, :inclusion => { :in => [1..5] }
end
