class BannerItemsController < ApplicationController
  before_action :set_banner_item, only: [:show, :edit, :update, :destroy]

  def index
    @banner_items = BannerItem.all
  end

  def show
  end

  def new
    @banner_item = BannerItem.new
  end

  def edit
  end

  def create
    @banner_item = BannerItem.new(banner_item_params)

    if @banner_item.save
      redirect_to @banner_item, notice: 'banner_item was successfully created.'
    else
      render :new
    end
  end

  def update
    if @banner_item.update(banner_item_params)
      redirect_to @banner_item, notice: 'banner_item was successfully updated.'
    else
      render :edit 
    end
  end

  def destroy
    @banner_item.destroy
    redirect_to banner_items_url, notice: 'banner_item was successfully destroyed.'
  end

  private
    def set_banner_item
      @banner_item = BannerItem.find(params[:id])
    end

    def banner_item_params
      params.require(:banner_item).permit(:image_id, :banner_id, :product_id, :name)
    end
end
