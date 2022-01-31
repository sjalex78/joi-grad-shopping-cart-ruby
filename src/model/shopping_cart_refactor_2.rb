# frozen_string_literal: true

require './src/model/order'

class ShoppingCart
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
    total_price = 0

    loyalty_points_earned = 0
    @products.each do |product|
      loyalty_points_earned += calculate_loyalty_points(product)
      total_price += total_price_for(product)
    end

    Order.new total_price, loyalty_points_earned
  end

  def discount_rate_for(product)
    parse_product = product.product_code.match(/(\w+)_(\d+)/)
    return 0 if parse_product == nil

    parse_product[2].to_i
  end

  def calculate_loyalty_points(product)
    discount_rate = discount_rate_for(product)
    return product.price / 5 if discount_rate <= 0

    product.price / discount_rate
  end

  def total_price_for(product)
    product.price - product.price * (discount_rate_for(product)).fdiv(100)
  end

  def to_s
    "Customer: #{@customer.name}\n" \
      "Bought: \n#{@products.map { |product| "- #{product.name}, #{product.price}" }.join("\n")}"
  end
end
