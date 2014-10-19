class OrderItemsController < ApplicationController

  def update
    #raise params[:order_item].inspect
    @order = Order.find_by(id: session[:order_id])
    params[:order_item].each do |k, v|
      @order_item = OrderItem.find_by(id: k)
      quantity_diff = v.to_i - @order_item.quantity_of_product
      @order_item.quantity_of_product += quantity_diff
    if @order_item.valid?
      update_cart(quantity_diff, @order_item)
    else
      @order_item.save
    end
    v == "0" ? @order_item.destroy : nil

    # params[:order_item].each do |k, v|
    #     @order_item = OrderItem.find_by(id: k)
    #     quantity_diff = v.to_i - @order_item.quantity_of_product
    #


    render "orders/show"
    #redirect_to order_path("new_cart")
  end

end
