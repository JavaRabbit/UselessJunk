module RatingHelper
  def average_rating(product)
    if product.reviews.empty?
      return "No rating data"
    else
      average = 0
      product.reviews.each do |review|
        average += review.rating.to_i
      end
        average / product.reviews.count
    end
  end
end
