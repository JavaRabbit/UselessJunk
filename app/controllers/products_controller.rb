class ProductsController < ApplicationController

  def index
    @user = User.new
    @products = Product.all
    @product = Product.find_by(id: params[:id])
  end

  def new
    @product = Product.new
    @user = User.first
    # @user = User.find_by(id: session[:user_id])
    # this^ once login/session works
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      user_id = @product.user_id
      redirect_to user_path(user_id)
    else
      @user = User.first
      render :new
    end
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

  def product_params
    params.require(:product).permit(:name, :description, :price, :quantity, :imageurl, :user_id)
  end

end
