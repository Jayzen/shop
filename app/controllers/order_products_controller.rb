class OrderProductsController < ApplicationController
  before_action :set_order_product, only: [:show, :edit, :update, :destroy]

  def index
    @order_products = OrderProduct.all
  end

  def show
  end

  def new
    @order_product = OrderProduct.new
  end

  def edit
  end

  def create
    @order_product = OrderProduct.new(order_product_params)

    if @order_product.save
      redirect_to @order_product, notice: 'order_product was successfully created.'
    else
      render :new
    end
  end

  def update
    if @order_product.update(order_product_params)
      redirect_to @order_product, notice: 'order_product was successfully updated.'
    else
      render :edit 
    end
  end

  def destroy
    @order_product.destroy
    redirect_to order_products_url, notice: 'order_product was successfully destroyed.'
  end

  private
    def set_order_product
      @order_product = OrderProduct.find(params[:id])
    end

    def order_product_params
      params.require(:order_product).permit(:order_id, :product_id, :count)
    end
end
