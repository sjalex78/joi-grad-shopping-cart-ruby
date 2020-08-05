require './src/model/shopping_cart'
require './src/model/customer'
require './src/model/product'

RSpec.describe ShoppingCart do

  it "should validate information passed on to confirmation" do
    cart = ShoppingCart.new(Customer.new("test"), [] << Product.new(100, "DIS_10_ABCD", "T"))
    order = cart.checkout()

    expect(order.total_price).to eq 90.0
  end
end
