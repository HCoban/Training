require 'rspec/autorun'

def buy_and_sell_stock_twice(prices)
  sell_at_index = []
  minimum = nil
  maximum = nil

  prices.each do |price|
    if minimum.nil? || price < minimum
      minimum = price
    end

    if maximum.nil? || (price - minimum) > maximum
      maximum = price - minimum
    end

    sell_at_index.push(maximum)
  end

  maximum = nil
  i = prices.length - 1
  maximum_profit = nil

  while i > 0
    if maximum.nil? || prices[i] > maximum
      maximum = prices[i]
    end

    sell_from_today = (maximum - prices[i]) + sell_at_index[i-1]

    if maximum_profit.nil? || sell_from_today > maximum_profit
      maximum_profit = sell_from_today
    end

    i -= 1
  end

  maximum_profit
end


stock_prices = [12, 11, 13, 9, 12, 8, 14, 13, 15]

describe "buy_and_sell_stock_twice" do
  it "correctly calculates maximum profit" do
    expect(buy_and_sell_stock_twice(stock_prices)).to be(10)
  end
end
