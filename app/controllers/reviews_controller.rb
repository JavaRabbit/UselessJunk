class ReviewsController < ApplicationController

  def create
    params = ""
    @review = Review.new(review_params)
    @order_item = OrderItem.new
    product_id = @review.product_id
    @product = Product.find(product_id)
    if @review.save
      redirect_to product_path(product_id)
    else
      render "products/show"
    end
  end

  def product_id
    @Product.find_by(id: params[:id])
  end

  private

  def rating_to_int(string)
    string.to_i
  end

  def set_product_id
    @product = Product.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:title, :content, :product_id, :rating)
  end
end
