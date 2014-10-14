class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.text :name
      t.text :description
      t.text :imageurl
      t.integer :price
      t.integer :quantity
      t.integer :user_id

      t.timestamps
    end
  end
end
