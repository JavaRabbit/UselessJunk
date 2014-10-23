module MoneyHelper

  def format_money(cents)
    dollar  = cents.to_f / 100
    decimal = dollar.to_s.split(".").last
    decimal = decimal_length(decimal)
    html = "<span class='dollar-symbol'>$</span>" +
    "<span class='dollar-amount'>#{dollar.floor}</span>" +
    "<span class='dollar-decimal'>.#{decimal}</span>"
    html.html_safe
  end

  private

  def decimal_length(decimal)
    loop do
      if decimal.length == 2
        return decimal
      elsif decimal.length > 2
        decimal = decimal.slice!(0..1)
      elsif decimal.length < 2
        decimal += "0"
      end
    end
  end

end
