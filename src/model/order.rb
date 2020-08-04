class Order < ShoppingCart
  def initialize customer, products
    super customer, products, "ORDER_PLACED"
  end
end
