class OrdersController < ApplicationController
  def show
    @order = Order.find_by(id: session[:order_id])
  end

  def create
    if session[:order_id]
      @order = Order.find_by(id: session[:order_id])
    else
      @order = Order.create
      session[:order_id] = @order.id
    end

    @order_item = @order.order_items.find_by(product_id: params[:order_item][:product_id])
    if @order_item
      @order_item.quantity_of_product += 1

    else
      @order_item = OrderItem.create(quantity_of_product: 1, order_id: session[:order_id], product_id: params[:order_item][:product_id])
    end
    # Should redirect to the page where you clicked add to cart, but doesn't yet!
    @order_item.save
    redirect_to products_path
  end
end
