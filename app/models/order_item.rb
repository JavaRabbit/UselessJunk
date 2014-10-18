class OrderItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :order

  validate :product_stock_must_exceed_order_item_quantity

  def product_stock_must_exceed_order_item_quantity
    if quantity_of_product > product.quantity
      errors.add(:quantity_of_product, "exceeds available product stock")
    end
  end

end
