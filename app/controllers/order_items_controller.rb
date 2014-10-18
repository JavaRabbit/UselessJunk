class OrderItemsController < ApplicationController

  def update
    @order = Order.find_by(id: session[:order_id])
    params[:order_item].each do |k, v|
        @order_item = OrderItem.find_by(id: k)
        quantity_diff = v.to_i - @order_item.quantity_of_product
        #if order_item.product.quantity >= quantity_diff
        update_cart(quantity_diff, @order_item)
        #else
        #  order_item.save
        #end
        v == "0" ? @order_item.destroy : nil


    end
    render "orders/show"
    #redirect_to order_path("new_cart")
  end

end
