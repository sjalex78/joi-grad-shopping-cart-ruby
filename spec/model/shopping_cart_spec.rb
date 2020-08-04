require './src/service/order_service'
require './src/model/shopping_cart'
require './src/model/customer'
require './src/model/product'

RSpec.describe ShoppingCart do

  it "should validate information passed on to confirmation" do
    cart = ShoppingCart.new(Customer.new("test"), [] << Product.new(100, "DIS_10_ABCD", "T"))
    fake_order_service = FakeOrderService.new
    cart.set_order_service(fake_order_service)
    cart.checkout()

    expect(fake_order_service.actual_total_price).to eq 90.0
  end

  class FakeOrderService < OrderService
    attr_reader :actual_total_price

    def show_confirmation customer, products, total_price, loyalty_points_earned
      @actual_total_price = total_price
    end
  end
end
