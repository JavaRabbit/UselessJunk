module RetiredHelper

  def retired_products
    retired_products = []
    Product.all.each do |product|
      if product.retired then retired_products << product end
    end
    retired_products
  end
  
end
