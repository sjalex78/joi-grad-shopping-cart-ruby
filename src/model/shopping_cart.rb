require './src/model/order'

class ShoppingCart

  def initialize customer, products
    @customer = customer
    @products = products
  end

  def add_product product
    @products.push(product)
  end

  def remove_product product
    @products.delete_at(@products.index(product) || @products.length)
  end

=begin
    Checkout: Calculates total price and total loyalty points earned by the customer.
    Products with product code starting with DIS_10 have a 10% discount applied.
    Products with product code starting with DIS_15 have a 15% discount applied.

    Loyalty points are earned more when the product is not under any offer.
        Customer earns 1 point on every $5 purchase.
        Customer earns 1 point on every $10 spent on a product with 10% discount.
        Customer earns 1 point on every $15 spent on a product with 15% discount.
=end

  def checkout()
    total_price = 0

    loyalty_points_earned = 0
    # loyalty_points_earned = @products.sum{ loyalty_points_for(_1)}
    @products.each do |product|
      loyalty_points_earned += loyalty_points_for(product)
      total_price += product.price - discount_for(product)
    end

    return Order.new total_price, loyalty_points_earned
  end

  def loyalty_points_for(product)
    product.price / percentage_for(product)
  end

  def discount_for(product)
    product.price * percentage_discount_for(product)
  end

  def percentage_discount_for(product)
    discount_rate = discount_rate_for(product)
    if discount_rate == nil
      0
    else
      discount_rate.fdiv(100)
    end
  end

  def percentage_for(product)
    discount_rate = discount_rate_for(product)
    if discount_rate == nil
      5
    else
      discount_rate
    end
  end

  def discount_rate_for(product)
    matches = product.product_code.match(/^DIS_(\d+)/)
    matches && matches[1].to_i
  end

  def to_s
    "Customer: #{@customer.name}\n" +
    "Bought: \n#{@products.map { |product| "- #{product.name}, #{product.price}" }.join("\n")}"
   end

end
