class Review < ActiveRecord::Base
  belongs_to :product

  validates :title, :content, :product_id, :rating, presence: true
  validates :rating, :numericality => {:only_integer => true, :greater_than => 0, :less_than => 6}

end
