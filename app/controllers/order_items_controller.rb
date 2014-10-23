class OrderItemsController < ApplicationController

  def update
    @order_item = OrderItem.new
    @errors_array = []
    params[:order_item].each do |k, v|
      order_item = OrderItem.find_by(id: k)
      quantity_diff = v.to_i - order_item.quantity_of_product
      failed_save = update_cart(quantity_diff, order_item)
      if failed_save
        @errors_array << failed_save
      end
    end

    params[:order_item][:quantity] == "0" ? @order_item.destroy : nil
    @order = Order.find_by(id: session[:order_id])
    render "orders/show"

  end

end
