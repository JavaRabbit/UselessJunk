module RatingHelper
  def average_rating(product)
    average = 0
    product.reviews.each do |review|
      average += review.rating.to_i
    end
      average/product.reviews.count
  end
end
