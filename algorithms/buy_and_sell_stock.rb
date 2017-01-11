def buy_and_sell_stock(prices)
  minimum = nil
  maximum = nil

  prices.each do |price|
    minimum = price if minimum.nil? || price < minimum
    maximum = price - minimum if maximum.nil? || (price - minimum) > maximum
  end

  maximum
end



stock_prices = [310, 315, 275, 295, 260, 270, 290, 230, 255, 250]
puts buy_and_sell_stock(stock_prices)
