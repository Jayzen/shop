class ProductPropertiesController < ApplicationController
  before_action :set_product_property, only: [:show, :edit, :update, :destroy]

  def index
    @product_properties = ProductProperty.all
  end

  def show
  end

  def new
    @product_property = ProductProperty.new
  end

  def edit
  end

  def create
    @product_property = ProductProperty.new(product_property_params)

    if @product_property.save
      redirect_to @product_property, notice: 'product was successfully created.'
    else
      render :new
    end
  end

  def update
    if @product_property.update(product_property_params)
      redirect_to @product_property, notice: 'product was successfully updated.'
    else
      render :edit 
    end
  end

  def destroy
    @product_property.destroy
    redirect_to product_properties_url, notice: 'product was successfully destroyed.'
  end

  private
    def set_product_property
      @product_property = ProductProperty.find(params[:id])
    end

    def product_property_params
      params.require(:product_property).permit(:name, :detail, :product_id)
    end
end
