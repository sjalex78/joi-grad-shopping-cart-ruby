require './src/model/shopping_cart'
require './src/model/customer'
require './src/model/product'

RSpec.describe ShoppingCart do

  it "should calculate correct price for item without discount" do
    # skip
    cart = ShoppingCart.new(Customer.new("test"), [] << Product.new(100, "no_discount_ABCD", "T"))
    order = cart.checkout()

    expect(order.total_price).to eq 100.0
  end

  it "should calculate correct loyalty points for item without discount" do
    # skip
    cart = ShoppingCart.new(Customer.new("test"), [] << Product.new(100, "no_discount_ABCD", "T"))
    order = cart.checkout()

    expect(order.loyalty_points).to eq 20
  end

  it "should calculate correct price for item with 10% discount" do
    # skip
    cart = ShoppingCart.new(Customer.new("test"), [] << Product.new(100, "DIS_10_ABCD", "T"))
    order = cart.checkout()

    expect(order.total_price).to eq 90.0
  end

  it "should calculate correct loyalty points for item with 10% discount" do
    # skip
    cart = ShoppingCart.new(Customer.new("test"), [] << Product.new(100, "DIS_10_ABCD", "T"))
    order = cart.checkout()

    expect(order.loyalty_points).to eq 10
  end

  it "should calculate correct price for item with 15% discount" do
    # skip
    cart = ShoppingCart.new(Customer.new("test"), [] << Product.new(100, "DIS_15_ABCD", "T"))
    order = cart.checkout()

    expect(order.total_price).to eq 85.0
  end

  it "should calculate correct loyalty points for item with 15% discount" do
    # skip
    cart = ShoppingCart.new(Customer.new("test"), [] << Product.new(100, "DIS_15_ABCD", "T"))
    order = cart.checkout()

    expect(order.loyalty_points).to eq 6
  end
end
