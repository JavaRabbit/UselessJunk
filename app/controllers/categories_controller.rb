class CategoriesController < ApplicationController
  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    @product = Product.new
    @all_categories = Category.all
    if @category.save
      render "products/new"
    else
      render "products/new"
    end
  end

  private

  def category_params
    params.require(:category).permit(:label)
  end

end
