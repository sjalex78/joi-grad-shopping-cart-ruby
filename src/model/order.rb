class Order
  attr_reader :total_price, :loyalty_points

  def initialize total_price, loyalty_points
    @total_price = total_price
    @loyalty_points = loyalty_points
  end

  def to_s
    "Total price: #{@total_price}\n" +
    "Will receive #{@loyalty_points} loyalty points"
   end
end
