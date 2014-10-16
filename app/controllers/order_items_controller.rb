class OrderItemsController < ApplicationController

  def update
    params[:order_item].each do |k, v|
        order_item = OrderItem.find_by(id: k)
        if v == "0"
          order_item.destroy
        else
          order_item.quantity_of_product = v
          order_item.save
        end

    end

    redirect_to order_path("new_cart")
  end

end
