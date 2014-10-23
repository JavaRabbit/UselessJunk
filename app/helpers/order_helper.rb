module OrderHelper

  def format_order(order)
    id = order.id
    status = order.state
    buyer_name = order.buyer_name
    email = order.email
    address = order.address
    last_four = order.last_four
    expiration = order.expiration
    if order.date_ordered
      order_date = order.date_ordered.in_time_zone("Pacific Time (US & Canada)").strftime("%m/%d/%y, %I:%M")
    end
    html = "<h3>Order #{id}</h3>" +
          "<p>Status: #{status}</p>" +
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
