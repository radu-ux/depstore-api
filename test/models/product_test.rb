require "test_helper"

class ProductTest < ActiveSupport::TestCase
  test "all attributes should be present" do
    empty_product = Product.new(name: "", description: "", price: "", quantity: "", on_sale: "")
    assert_not empty_product.valid?
  end

  test "qunatity should be valid" do
    product = Product.new(name: "Test Product", description: "Test Description", price: 121.22, quantity: -1, on_sale:true)
    assert_not product.valid?
  end

  test "price should be valid" do 
    product = Product.new(name: "Test Product", description: "Test Description", price: 0, quantity: 2, on_sale:true)
    assert_not product.valid?
  end

  test "name should be unique" do
    nike_shoes = products(:nike_shoes)
    other_nike_shoes = Product.new(name: nike_shoes.name, description: "Some other description", price: 221.22, quantity: 1, on_sale:true)
    
    assert_not other_nike_shoes.valid?
  end
end
