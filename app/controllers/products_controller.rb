class ProductsController < ApplicationController

  def show
    @product = Product.find_by(id: params[:id])
    if @product == nil
      redirect_to "/"
    end
    @review = Review.new
  end

end
