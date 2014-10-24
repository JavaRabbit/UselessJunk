class OrderItemsController < ApplicationController

  def update
    # raise params.inspect
    @order_item = OrderItem.new
    @errors_array = []
    params[:order_item].each do |k, v|
      order_item = OrderItem.find_by(id: k)
      quantity_diff = v.to_i - order_item.quantity_of_product
      if v.to_i == 0
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

    #setting quantity of product to 0 should delete
    # adding something to cart should not update stock, only when you buy it

    render "orders/cart"

  end

end
