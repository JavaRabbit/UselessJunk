class CategoriesController < ApplicationController
before_filter only: [:new, :update, :destroy]

  def new
    @category = Category.new
    session[:product_id] = params[:id]
    #I use the session so that when you create the category,
    # it knows to redirect you back to either the new_product_path or the
    # edit_product_path. There may be a better way to do this.
    # (this way is limited b/c you have to build a new route for every place
    # that you link to new from) -Cate
  end

  def create
    @category = Category.new(category_params)
    @product = Product.new
    if @category.save
      if session[:product_id]
        redirect_to edit_product_path(session[:product_id])
      else
        redirect_to new_product_path
      end
    else
      render "products/new"
    end
  end

  def show
    category = Category.find_by(id: params[:id])
    @categories = [category]
    @products = []
    Product.all.each do |product|
      if product.categories.include? category
        @products << product
      end
    end
    raise @products.inspect
    render 'products/index'
  end

  def sort
    @products = []
    @categories = []
    if params[:category_ids]
      params[:category_ids].each do |cat_id|
        product_set = Product.includes(:categories).where(categories:{id: cat_id})
        product_set.each do |product|
          unless @products.include? product
            @products << product
            product.categories.each do |cat|
              @categories << cat
            end
          end
        end
      end
      render "products/index"
    else
      redirect_to root_path
    end
  end

  private

  def category_params
    params.require(:category).permit(:label)
  end

end
