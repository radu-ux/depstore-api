class ProductsController < ApplicationController
    before_action :get_attributes, only: [:create, :update]
    before_action :find_product_by_id, only: [:show, :update, :destroy]

    def index
        @products = Product.all
        render json: {products: @products}, status: :ok
    end

    def show
        render json: {product: @product}, status: :ok 
    end

    def create
        @product = Product.create!(@attributes)
        render json: {product: @product}, status: :ok
    end

    def update
        @product.update(@attributes)
        
        if @product.errors.empty?
            head :ok
        else
            render json: {message: @product.errors.full_messages.join(",")}, status: :unprocessable_entity
        end
    end

    def destroy
        @product.destroy

        head :no_content
        # render json: {params: params}
    end

    private 
    def get_attributes 
        @attributes = params.require(:product).permit(:name, :description, :price, :quantity, :on_sale)
    end

    def find_product_by_id 
        @product = Product.find(params[:id])
    end
end
