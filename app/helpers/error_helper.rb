module ErrorHelper

  def error_message(obj)
    html =
    "<% if .errors.any? %>
      <ul class='error-messages'>
        <% #{obj}.errors.each do |column_name, message| %>
          <li>
            <strong><%= column_name.capitalize %></strong> <%= message %>
          </li>
        <% end %>
      </ul>
     <% end %>"
     html.html_safe
  end


end
