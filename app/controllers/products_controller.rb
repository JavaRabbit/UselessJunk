class ProductsController < ApplicationController
  before_filter :user_is_current_user, :authorize, only: [:edit, :update]

  def index
    @user = User.new
    @products = Product.all
    @product = Product.find_by(id: params[:id])
  end

  def new
    @product = Product.new
    @categories = Category.all
  end

  def create
    @categories = Category.all
    @product = Product.new(product_params)
    if @product.save
      redirect_to @product
    else
      render :new
    end
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to @product
    else
      render :edit
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
    redirect_to current_user, notice: "Product deleted!"
  end

  def edit
    @product = Product.find(params[:id])
  end


  def product_params
    params.require(:product).permit(:name, :description, :price, :quantity, :imageurl, :user_id)
  end

  private
  def user_is_current_user

    unless current_user.id == Product.find(params[:id]).user_id
      flash[:notice] = "You may only edit/delete your own products."
      redirect_to root_path
    end
  end
end
