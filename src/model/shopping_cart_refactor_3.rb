# frozen_string_literal: true

require './src/model/order'

class ShoppingCart
  BASE_LOYALTY_POINTS = 5

  def initialize(customer, products)
    @customer = customer
    @products = products
  end

  def add_product(product)
    @products.push(product)
  end

  def remove_product(product)
    @products.delete_at(@products.index(product) || @products.length)
  end

  #     Checkout: Calculates total price and total loyalty points earned by the customer.
  #     Products with product code starting with DIS_10 have a 10% discount applied.
  #     Products with product code starting with DIS_15 have a 15% discount applied.
  #
  #     Loyalty points are earned more when the product is not under any offer.
  #         Customer earns 1 point on every $5 purchase.
  #         Customer earns 1 point on every $10 spent on a product with 10% discount.
  #         Customer earns 1 point on every $15 spent on a product with 15% discount.

  def checkout
    cart_total_price = 0
    loyalty_points_earned = 0

    @products.each do |product|
      cart_total_price += price_with_discount_for(product)
      loyalty_points_earned += calculate_loyality_points_for(product)
    end

    Order.new cart_total_price, loyalty_points_earned
  end

  def to_s
    "Customer: #{@customer.name}\n" \
    "Bought: \n#{@products.map { |product| "- #{product.name}, #{product.price}" }.join("\n")}"
  end

  def discount_rate_for(product)
    matches = product.product_code.match(/(\w+)_(\d+)/)
    # pp matches[2].to_i
    return 0 if matches.nil?

    matches[2].to_i
  end

  def calculate_loyality_points_for(product)
    loyalty_points_denominator = [discount_rate_for(product), BASE_LOYALTY_POINTS].max
    (price_with_discount_for(product) / loyalty_points_denominator).floor
  end

  def price_with_discount_for(product)
    product.price - (product.price * discount_rate_for(product).fdiv(100))
  end

  def calculate_cart_total_for(product)
    product_price = product.price - (product.price * discount_rate_for(product).fdiv(100))
    cart_total_price += product_price
  end
end
