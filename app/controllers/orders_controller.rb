class OrdersController < ApplicationController
before_filter :authorize_order, only: [:buy, :pay]
before_filter :authorize_user_has_order, only: [:show]

  def show
    @order = Order.find_by(id: params[:id])
  end

  def cart
    find_or_create
    @order_item = OrderItem.new
  end

  def add_to_cart
    @order = find_or_create
    add_order_item(@order)
    # Should redirect to the page where you clicked add to cart, but doesn't yet!
    redirect_to cart_path
  end

  def buy
  end

  def pay
    current_order.state = "paid"
    current_order.date_ordered = DateTime.now
    if current_order.update(order_params)
      session[:order_id] = nil
      redirect_to order_confirm_path(current_order.id), notice: "Order Approved! Thank you!"
    else
      render :buy, notice: "Order Incomplete!"
    end
  end

  def confirm
    @order = Order.find(params[:id])
  end

  private

  def new_order
    order = Order.create(state: "pending", total_price: 0)
    session[:order_id] = order.id
    order
  end

  def find_or_create
    current_order || new_order
  end

  def add_order_item(order)
    p_id = params[:order_item][:product_id]
    order_item = order.order_items.find_by(product_id: p_id)
    unless order_item
      order_item = OrderItem.create(quantity_of_product: 0, order_id: session[:order_id], product_id: p_id, subtotal: 0)
    end
    update_cart(1, order_item)
  end

  def order_params
    params.require(:order).permit(:buyer_name, :email, :address, :last_four, :expiration)
  end

end
