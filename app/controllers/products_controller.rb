class ProductsController < ApplicationController

<<<<<<< HEAD
  def index
    @products = Product.all
=======
  def show
    @product = Product.find_by(id: params[:id])
    if @product == nil
      redirect_to "/"
    end
    @review = Review.new
>>>>>>> master
  end

end
