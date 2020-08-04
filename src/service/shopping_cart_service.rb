class ShoppingCartService

  def checkout customer, products
    cart = ShoppingCart.new customer, products, "OPEN"

    cart.checkout()
  end
end
