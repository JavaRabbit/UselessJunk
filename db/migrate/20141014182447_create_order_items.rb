class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.integer :quantity_of_product
      t.integer :subtotal
      t.integer :order_id
      t.integer :product_id

      t.timestamps
    end
  end
end
