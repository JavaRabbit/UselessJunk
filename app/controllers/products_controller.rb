class ProductsController < ApplicationController

  def index
    @products = Product.all
    @product = Product.find_by(id: params[:id])
  end


  def show
    @product = Product.find_by(id: params[:id])
    if @product == nil
      redirect_to root_path
    end
    @order_item = OrderItem.new
    @review = Review.new
  end

  def destroy
    product = Product.find(params[:id])
    delete_product(product)
    redirect_to products_path
  end

  def edit
    @product = Product.find(params[:id])
  end

end
