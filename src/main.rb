require './src/model/product'
require './src/model/customer'
require './src/model/shopping_cart'
require './src/service/order_service'

class ConsoleOrderService < OrderService

  def show_confirmation customer, products, total_price, loyalty_points_earned
    items = products.map { |product| "- #{product.name}, #{product.price}" }.join("\n")

    puts "Customer: #{customer.name}"
    puts "Bought: \n#{items}"
    puts "Total Price: #{total_price}"
    puts "Will receive #{loyalty_points_earned} loyalty points"
  end

end

def main
  product_1 = Product.new(10.0, "DIS_10_PRODUCT1", "product 1")
  product_2 = Product.new(20.0, "DIS_10_PRODUCT2", "product 2")
  products = [product_1, product_2]

  customer = Customer.new('A Customer')

  shopping_cart = ShoppingCart.new(customer, products)
  shopping_cart.set_order_service(ConsoleOrderService.new);

  product_3 = Product.new(30.0, "DIS_10_PRODUCT3", "product 3")
  shopping_cart.add_product(product_3)

  shopping_cart.checkout
end

