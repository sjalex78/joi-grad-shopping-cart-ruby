class Product
  attr_reader :name, :price, :product_code

  def initialize price, product_code, name
    @price = price
    @product_code = product_code
    @name = name
  end

end
