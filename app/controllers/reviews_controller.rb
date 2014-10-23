class ReviewsController < ApplicationController
  before_filter :if_not_owned_by_current_user, only: [:create]

  def create
    @review = Review.new(review_params)
    if @review.save
      product_id = @review.product_id
      redirect_to product_path(product_id)
    end
  end

  def product_id
    @Product.find_by(id: params[:id])
  end

  private

  def set_product_id
    @product = Product.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:title, :content, :product_id, :rating)
  end
end
