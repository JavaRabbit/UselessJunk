class AddDateOrderedAttrToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :date_ordered, :datetime
  end
end
