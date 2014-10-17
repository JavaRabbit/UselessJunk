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

  def update_cart(quantity_diff, order_item)
    order_item.quantity_of_product += quantity_diff
    order_item.product.quantity -= quantity_diff
    order_item.subtotal += (order_item.product.price * quantity_diff)
    order_item.save
    order_item.product.save
  end

end
