class ReviewsController < ApplicationController
  before_filter :review_is_current_user, :authorize, only: [:create]

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

  def review_is_current_user
    if current_user == @product_id
      flash[:notice] = "You are prohibited from reviewing your own products."
      redirect_to root_path
    end
  end

  def set_product_id
    @product = Product.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:title, :content, :product_id, :rating)
  end
end
