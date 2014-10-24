class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  helper :all
  protect_from_forgery with: :exception


  def logged_user
    User.find_by id: session[:user_id]
  end

  def delete_user(user)
    user.products.each do |product|
      delete_product(product)
    end
    user.destroy
  end

  def delete_product(product)
    product.reviews.each do |review|
      review.destroy
    end
    product.destroy
  end


  def update_cart(quantity_diff, order_item)
    order_item.quantity_of_product += quantity_diff
    price_change = order_item.product.price * quantity_diff
    order_item.subtotal += price_change
    if order_item.save
      order_item.product.quantity -= quantity_diff
      order_item.product.save
      order_item.order.total_price += price_change
      order_item.order.save
      # raise order_item.order.inspect

      return nil
    else
      return order_item
    end
  end

# makes it available for all controllers.
# find user model by sessions Id (stated earlier inside sessions
# controller) when the user logged in only if session variable user exists
# Cach instance variable so it can be fetched one time per request. It will be called many times.

# helper_method to fetch the current_user to be accessible in the view
  private
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
  helper_method :current_user

  def all_categories
    Category.all
  end
  helper_method :all_categories

  def current_order
    @current_order ||= Order.find_by(id: session[:order_id])
  end
  helper_method :current_order

  def retired_products
    Product.where(retired: true)
  end
  helper_method :retired_products

  def order_total_price
    current_order.total_price = 0
    current_order.order_items.each do |item|
      current_order.total_price += item.subtotal
    end
    current_order.save
    return current_order.total_price
  end
  helper_method :order_total_price

# if current user

# to give access to specific page

  def authorize
    redirect_to login_url, alert: "Not authorized" if !current_user
  end

  def authorize_order
    redirect_to order_path("cart"), alert: "Expired Order" if current_order.id.to_s != params[:id]
  end

  def authorize_user_has_order
    my_order = false
    current_user.order_items.each do |item|
      if item.order.id == params[:id].to_i
        my_order = true
      end
    end
    redirect_to root_path, alert: "No access to this order" if my_order == false
  end
end
