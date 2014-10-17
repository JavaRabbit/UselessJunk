class OrderItemsController < ApplicationController

  def update
    params[:order_item].each do |k, v|
        order_item = OrderItem.find_by(id: k)
        quantity_diff = v.to_i - order_item.quantity_of_product
        update_cart(quantity_diff, order_item)
        v == "0" ? order_item.destroy : nil


    end

    redirect_to order_path("new_cart")
  end

end
