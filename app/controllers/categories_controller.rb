class CategoriesController < ApplicationController
  def new
    @category = Category.new
  end

  def create
    @product = 
    @category = Category.new(category_params)
    if @category.save
      redirect_to @product
    else
      render :new
    end
  end

  private

  def category_params
    params.require(:category).permit(:label)
  end

end
