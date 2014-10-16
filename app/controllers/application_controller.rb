class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception

  def logged_user
    User.find_by id: session[:user_id]
  end

  def delete_vendor(vendor)
    vendor.products.each do |product|
      delete_product(product)
    end
    vendor.destroy
  end

  def delete_product(product)
    product.reviews.each do |review|
      review.destroy
    end
    product.destroy
  end

end
