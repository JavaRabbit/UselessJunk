class OrderItemsController < ApplicationController

  def update
    # raise params[:order_item].inspect
    @order = Order.find_by(id: session[:order_id])
    @order_item = OrderItem.find_by(id: (params[:order_item][:order_item_id]).to_i)
    @order_item.quantity_of_product = params[:order_item][:quantity]
    if @order_item.save
      @order_item.quantity_of_product = (params[:order_item][:quantity]).to_i
      quantity_diff = params[:order_item][:quantity].to_i - @order_item.quantity_of_product
      update_cart(quantity_diff, @order_item)
    else

      @errors = @order_item.errors
    end

    # params[:order_item].each do |k, v|
    #   @order_item = OrderItem.find_by(id: k)
    #   quantity_diff = v.to_i - @order_item.quantity_of_product
    #   @order_item.quantity_of_product += quantity_diff
    # end
    # if @order_item.valid?
    #   update_cart(quantity_diff, @order_item)
    # else
    #   @order_item.save
    # end
    params[:order_item][:quantity] == "0" ? @order_item.destroy : nil


    render "orders/show"
  end

end
