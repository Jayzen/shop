class ThemesController < ApplicationController
  before_action :set_theme, only: [:show, :edit, :update, :destroy, :products_manage, :add_product, :delete_product]

  def index
    @themes = Theme.all
  end

  def show
  end

  def new
    @theme = Theme.new
  end

  def edit
  end

  def create
    @theme = Theme.new(theme_params)

    if @theme.save
      redirect_to @theme, notice: 'theme was successfully created.'
    else
      render :new
    end
  end

  def update
    if @theme.update(theme_params)
      redirect_to @theme, notice: 'theme was successfully updated.'
    else
      render :edit 
    end
  end

  def destroy
    @theme.destroy
    redirect_to themes_url, notice: 'theme was successfully destroyed.'
  end

  def products_manage
    @products = @theme.products
  end

  def add_product
    begin
      ThemeProduct.create(
        product_id: params[:theme][:products],
        theme_id: @theme.id
      )
      redirect_to products_manage_theme_path(@theme), notice: "add product successfully"
    rescue ActiveRecord::RecordNotUnique => e
      redirect_to products_manage_theme_path(@theme), notice: "add duplicate product"
    end
  end

  def delete_product
    if @theme_product = ThemeProduct.find_by(product_id: params[:id])
      @theme_product.destroy
    end
    redirect_to products_manage_theme_path(@theme)
  end

  private
    def set_theme
      @theme = Theme.find(params[:id])
    end

    def theme_params
      params.require(:theme).permit(:name, :description, :topic_img_id, :head_img_id)
    end
end
