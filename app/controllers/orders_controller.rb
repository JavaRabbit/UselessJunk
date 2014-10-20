class OrdersController < ApplicationController
before_filter :authorize_order, only: [:buy, :pay]

  def show
    @order = find_or_create
    @order_item = OrderItem.new
  end

  def add_to_cart
    @order = find_or_create
    add_order_item(@order)
    # Should redirect to the page where you clicked add to cart, but doesn't yet!
    redirect_to order_path(@order.id)
  end

  def find_or_create
    Order.find_by(id: session[:order_id]) || new_order
  end

  def add_order_item(order)
    p_id = params[:order_item][:product_id]
    order_item = order.order_items.find_by(product_id: p_id)
    unless order_item
      order_item = OrderItem.create(quantity_of_product: 0, order_id: session[:order_id], product_id: p_id, subtotal: 0)
    end
    update_cart(1, order_item)

  end

  def update
    order = Order.find_by(id: session[:order_id])
    order.state = "paid"
    order.save
    session[:order_id] = nil
    redirect_to order_path(order.id)
  end

  private

  def new_order
    order = Order.create(state: "pending", total_price: 0)
    session[:order_id] = order.id
    order
  end



end
