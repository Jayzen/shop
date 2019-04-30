class ProductPropertiesController < ApplicationController
  before_action :set_product
  before_action :set_product_property, only: [:show, :edit, :update, :destroy]

  def index
    @product_properties = @product.product_properties
  end

  def show
  end

  def new
    @product_property = @product.product_properties.new
  end

  def edit
  end

  def create
    @product_property = @product.product_properties.build(product_property_params)

    if @product_property.save
      redirect_to product_product_property_path(@product, @product_property), notice: 'product was successfully created.'
    else
      render :new
    end
  end

  def update
    if @product_property.update(product_property_params)
      redirect_to product_product_property_path(@product, @product_property), notice: 'product was successfully updated.'
    else
      render :edit 
    end
  end

  def destroy
    @product_property.destroy
    redirect_to product_product_properties_path(@product), notice: 'product was successfully destroyed.'
  end

  private
    def set_product_property
      @product_property = @product.product_properties.find(params[:id])
    end

    def product_property_params
      params.require(:product_property).permit(:name, :detail)
    end

    def set_product
      @product = Product.find(params[:product_id])
    end
end
