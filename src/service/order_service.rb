class OrderService

  def show_confirmation customer, products, total_price, loyalty_points_earned
    #show confirmation
    #do some calculations and formatting on the shopping cart data and ask user for confirmation
    #after confirmation redirect to place order
  end

  def place_order customer, products
    #place order
    return Order.new customer, products
  end

end
