class CategoriesController < ApplicationController
  def new
    @category = Category.new
    session[:product_id] = params[:id]
  end

  def set_prev_page
    session[:prev_page] = params[:page_id]
  end

  def create
    @category = Category.new(category_params)
    @product = Product.new
    @all_categories = Category.all
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

  private

  def category_params
    params.require(:category).permit(:label)
  end

end
