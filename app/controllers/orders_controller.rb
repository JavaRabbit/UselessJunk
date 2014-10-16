class OrdersController < ApplicationController

  def show
    @order = find_or_create
    @order_item = OrderItem.new
  end

  def add_to_cart
    @order = find_or_create
    add_order_item(@order)
    # Should redirect to the page where you clicked add to cart, but doesn't yet!
    redirect_to products_path
  end

  def find_or_create
    Order.find_by(id: session[:order_id]) || new_order
  end

  def add_order_item(order)
    p_id = params[:order_item][:product_id]
    order_item = order.order_items.find_by(product_id: p_id)
    if order_item
      order_item.quantity_of_product += 1
      order_item.subtotal += order_item.product.price
    else
      order_item = OrderItem.create(quantity_of_product: 1, order_id: session[:order_id], product_id: p_id )
      order_item.subtotal = order_item.product.price
    end
    order_item.product.quantity -= 1
    order_item.product.save
    order_item.save
    order.total_price += order_item.product.price
    order.save
  end

  def add_item(number, product)
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
