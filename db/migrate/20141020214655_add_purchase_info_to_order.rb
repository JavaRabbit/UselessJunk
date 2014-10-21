class AddPurchaseInfoToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :buyer_name, :string
    add_column :orders, :email, :string
    add_column :orders, :address, :string
    add_column :orders, :last_four, :integer
    add_column :orders, :expiration, :string
  end
end
