class ProductImagesController < ApplicationController
  before_action :set_product_image, only: [:show, :edit, :update, :destroy]

  def index
    @product_images = ProductImage.all
  end

  def show
  end

  def new
    @product_image = ProductImage.new
  end

  def edit
  end

  def create
    @product_image = ProductImage.new(product_images_param)

    if @product_image.save
      redirect_to @product_image, notice: 'product was successfully created.'
    else
      render :new
    end
  end

  def update
    if @product_image.update(product_images_param)
      redirect_to @product_image, notice: 'product was successfully updated.'
    else
      render :edit 
    end
  end

  def destroy
    @product_image.destroy
    redirect_to product_images_url, notice: 'product was successfully destroyed.'
  end

  private
    def set_product_image
      @product_image = ProductImage.find(params[:id])
    end

    def product_images_param
      params.require(:product_image).permit(:order, :image_id, :product_id)
    end
end
