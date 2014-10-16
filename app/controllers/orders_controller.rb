class OrdersController < ApplicationController
  def show
    raise session[:order_id].inspect
    @order = Order.find_by(id: session[:order_id])
    unless @order
      @order = new
    end
  end

  def create
    if session[:order_id]
      @order = Order.find_by(id: session[:order_id])
    else
      @order = new
    end

    p_id = params[:order_item][:product_id]
    @order_item = @order.order_items.find_by(product_id: p_id)
    if @order_item
      @order_item.quantity_of_product += 1
    else
      @order_item = OrderItem.create(quantity_of_product: 1, order_id: session[:order_id], product_id: p_id)
    end

    # Should redirect to the page where you clicked add to cart, but doesn't yet!
    @order_item.save
    redirect_to products_path
  end

  def update
    @order = Order.find_by(id: session[:order_id])
    @order.state = "paid"
    @order.save
    # session[:order_id] = nil
    redirect_to order_path(@order.id)
  end

  private

  def new
    order = Order.create(state: "pending", total_price: 0)
    session[:order_id] = order.id
    order
  end

end
