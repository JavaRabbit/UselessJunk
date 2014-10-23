module OrderHelper

  def format_order(order)
    id = order.id
    status = order.state
    total_price = order.total_price
    buyer_name = order.buyer_name
    email = order.email
    address = order.address
    last_four = order.last_four
    expiration = order.expiration
    order_date = order.updated_at
    html = "<h3>Order #{id}</h3>" +
          "<p>Status: #{status}</p>" +
          "<p>Total Price: " + format_money(total_price) + "</p>" +
          "<p>Order Placed: #{order_date}</p>" +
          "<p>Buyer Info</p>" +
          "<ul>" +
          "<li>Name: #{buyer_name}</li>" +
          "<li>Email: #{email}</li>" +
          "<li>Address: #{address}</li>" +
          "<li>Credit Card Number: **** **** **** #{last_four}</li>" +
          "<li>Expiration Date: #{expiration}</li>" +
          "</ul>"
    html.html_safe

  end

end
