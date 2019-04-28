class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  def index
    @orders = Order.all
  end

  def show
  end

  def new
    @order = Order.new
  end

  def edit
  end

  def create
    @order = Order.new(order_params)

    if @order.save
      redirect_to @order, notice: 'order was successfully created.'
    else
      render :new
    end
  end

  def update
    if @order.update(order_params)
      redirect_to @order, notice: 'order was successfully updated.'
    else
      render :edit 
    end
  end

  def destroy
    @order.destroy
    redirect_to orders_url, notice: 'order was successfully destroyed.'
  end

  private
    def set_order
      @order = Order.find(params[:id])
    end

    def order_params
      params.require(:order).permit(:order_no, :user_id, :total_price, :total_count, :status, :snap_img, :snap_name, :snap_items, :snap_address)
    end
end
