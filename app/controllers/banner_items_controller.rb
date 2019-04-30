class BannerItemsController < ApplicationController
  before_action :set_banner
  before_action :set_banner_item, only: [:show, :edit, :update, :destroy]

  def index
    @banner_items = @banner.banner_items
  end

  def show
  end

  def new
    @banner_item = @banner.banner_items.new
  end

  def edit
  end

  def create
    @banner_item = @banner.banner_items.new(banner_item_params)

    if @banner_item.save
      redirect_to banner_banner_item_path(@banner, @banner_item), notice: 'banner_item was successfully created.'
    else
      render :new
    end
  end

  def update
    if @banner_item.update(banner_item_params)
      redirect_to banner_banner_item_path(@banner, @banner_item), notice: 'banner_item was successfully updated.'
    else
      render :edit 
    end
  end

  def destroy
    @banner_item.destroy
    redirect_to banner_banner_items_path(@banner), notice: 'banner_item was successfully destroyed.'
  end

  private
    def set_banner_item
      @banner_item = @banner.banner_items.find(params[:id])
    end

    def banner_item_params
      params.require(:banner_item).permit(:image_id, :product_id, :name)
    end

    def set_banner
      @banner = Banner.find(params[:banner_id])
    end
end
