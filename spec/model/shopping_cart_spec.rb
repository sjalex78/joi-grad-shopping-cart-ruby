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

    expect(order.loyalty_points).to eq 9
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

    expect(order.loyalty_points).to eq 5
  end

  it "should calculate correct price for items with 15% discount and 0% discount in same transaction" do
    # skip
    cart = ShoppingCart.new(Customer.new("test"), [] << Product.new(100, "DIS_15_ABCD", "T") << Product.new(100, "no_discount_ABCD", "T"))
    order = cart.checkout()

    expect(order.total_price).to eq 185.0
  end
  it "should calculate correct loyalty points for items with 15% discount and 10% discount in the same cart" do
    # skip
    cart = ShoppingCart.new(Customer.new("test"), []  << Product.new(100, "DIS_15_ABCD", "T") << Product.new(100, "DIS_10_ABCD", "T"))
    order = cart.checkout()

    expect(order.loyalty_points).to eq 14
  end

  it "should calculate correct loyalty points for items with 50%" do
    # skip
    cart = ShoppingCart.new(Customer.new("test"), []  << Product.new(100, "DIS_50_ABCD", "T") << Product.new(100, "DIS_10_ABCD", "T"))
    order = cart.checkout()

    expect(order.loyalty_points).to eq 10
  end

  describe "discount_rate_for" do
    let(:cart) { ShoppingCart.new(Customer.new("test"), [])}

    it "allows for a discout as small as 1" do
      product = Product.new(100, "DIS_1", "example")
      expect(cart.discount_rate_for(product)).to eq 1 # you decide
    end
    it "allows typical 10 percent discount" do
      product = Product.new(100, "DIS_10", "example")
      expect(cart.discount_rate_for(product)).to eq 10 # you decide
    end
    it "ignores any decimal points" do
      product = Product.new(100, "DIS_10.99", "example")
      expect(cart.discount_rate_for(product)).to eq 10 # you decide
    end
    it "ignores any pre-pend text that is not DIS" do
      product = Product.new(100, "NIMBUS_2000", "example")
      expect(cart.discount_rate_for(product)).to eq 0 # you decide
    end
    it "allows dis and discount" do
      product = Product.new(100, "dis_10", "example")
      expect(cart.discount_rate_for(product)).to eq 10 # you decide
      product = Product.new(100, "discount_10", "example")
      expect(cart.discount_rate_for(product)).to eq 10 # you decide
    end
    it "ignore dicount over 100" do
      product = Product.new(100, "DIS_101", "example")
      expect(cart.discount_rate_for(product)).to eq 0 # you decide
    end
  end
end
