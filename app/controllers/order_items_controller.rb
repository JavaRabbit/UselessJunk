class OrderItemsController < ApplicationController

  def update
    @errors_array = []
    params[:order_item].each do |k, v|
      order_item = OrderItem.find_by(id: k)
      quantity_diff = v.to_i - order_item.quantity_of_product
      if /[^0-9]/.match(v)
        order_item.errors.add("Quantity of product", "must be a number")
        @errors_array << order_item
      elsif v.to_i == 0
        order_item.destroy
      elsif quantity_diff > order_item.product.quantity
        order_item.errors.add("Quantity of product", "exceeds available product stock")
        @errors_array << order_item
      else
        failed_save = update_cart(quantity_diff, order_item)
        if failed_save
          @errors_array << failed_save
        end
      end
    end

    @order_item = OrderItem.new
    render "orders/cart"

  end

end
