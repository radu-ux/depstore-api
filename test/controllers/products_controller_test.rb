require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
  test "should get all products" do 
    get products_url, as: :json
    json_response = JSON.parse(response.body)
  
    assert_response :success  
    assert_equal json_response["products"].class, Array
  end

  test "should get exiting product from database" do 
    existing_product = products(:nike_shoes)
    get products_url + "/#{existing_product.id}", as: :json
    json_response = JSON.parse(response.body)

    assert_response :success 
    assert_not_nil json_response["product"]
  end

  test "should return 404 status if product does not exist in database" do 
    get products_url + "/123", as: :json
    json_response = JSON.parse(response.body)

    assert_response :not_found
    assert_not_equal json_response['message'], ""
  end

  test "should create product" do 
    assert_difference("Product.count") do 
      post products_url, params: {product: {name: "Some product", description: "Some desctiption", price:22.11, quantity: 1, on_sale:true}}, as: :json 
    end

    assert_response :success
  end

  test "should not create product" do
    assert_no_difference("Product.count") do 
      post products_url, params: {product: {name: "", description: "Some desctiption", price:22.11, quantity: 1, on_sale:true}}, as: :json
    end

    assert_response :unprocessable_entity
  end

  test "should update product"do 
    nike_shoes = products(:nike_shoes)
    patch products_url + "/#{nike_shoes.id}", params: {product: {name: "Updated Name", description: "Updated description", price: 123.22, quantity: 1, on_sale: true}}, as: :json

    assert_response :success
  end

  test "should not update invalid product" do 
    nike_shoes = products(:nike_shoes)
    patch products_url + "/#{nike_shoes.id}", params: {product: {name: "", description: "Updated description", price: 123.22, quantity: 1, on_sale: true}}, as: :json

    assert_response :unprocessable_entity
  end

  test "should not update product that does not exist" do 
    patch products_url + "/123", params: {product: {name: "", description: "Updated description", price: 123.22, quantity: 1, on_sale: true}}, as: :json

    assert_response :not_found
  end

  test "should destroy product" do 
    assert_difference("Product.count", -1) do
      nike_shoes = products(:nike_shoes)
      delete products_url + "/#{nike_shoes.id}", as: :json
    end

    assert_response :no_content
  end
end
