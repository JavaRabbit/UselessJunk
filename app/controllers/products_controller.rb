class ProductsController < ApplicationController
<<<<<<< HEAD
before_filter :authorize_user_owns_product, only: [:edit, :update, :destroy]
=======
before_filter :user_owns_product, only: [:edit, :update, :destroy]
>>>>>>> temp


  def index
    @user = User.new
    @products = Product.all
    @product = Product.find_by(id: params[:id])
  end

  def new
    @product = Product.new
    @all_categories = Category.all
<<<<<<< HEAD
  end

  def new_cat
    @product = Product.new
    @category = Category.new
    @all_categories = Category.all
    @new_cat = true
    render :new
=======
>>>>>>> temp
  end

# product categories are updated only when successfully saved, because
# pushing a category into .categories saves automatically.
# If a creation or an update is not successful (rollback), we don't want
# a version of it lingering with only categories. I think.
  def create
    @all_categories = Category.all
    @product = Product.new(product_params)
    if @product.save
      params[:category_ids].each do |id|
        cat = Category.find_by(id: id)
        @product.categories << cat
      end
      redirect_to @product
    else
      render :new
    end
  end

  def update
    @all_categories = Category.all
    @product = Product.find(params[:id])
    if @product.update(product_params)
      @product.categories = []
      if params[:category_ids]
        params[:category_ids].each do |id|
          cat = Category.find_by(id: id)
          @product.categories << cat
        end
      end
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
<<<<<<< HEAD
    @product = Product.find(params[:id])
    @all_categories = Category.all
=======
  @all_categories = Category.all
  @product = Product.find(params[:id])
>>>>>>> temp
  end


  def product_params
    params.require(:product).permit(:name, :description, :price, :quantity, :imageurl, :user_id, :categories)
  end

  private

  def user_owns_product
    product = Product.find_by(id: params[:id])
    redirect_to product_path(product.id), alert: "Not authorized" if current_user != product.user
  end

end
