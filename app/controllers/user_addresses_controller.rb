class UserAddressesController < ApplicationController
  before_action :set_user_address, only: [:show, :edit, :update, :destroy]

  def index
    @user_addresses = UserAddress.all
  end

  def show
  end

  def new
    @user_address = UserAddress.new
  end

  def edit
  end

  def create
    @user_address = UserAddress.new(user_address_params)

    if @user_address.save
      redirect_to @user_address, notice: 'user was successfully created.'
    else
      render :new
    end
  end

  def update
    if @user_address.update(user_address_params)
      redirect_to @user_address, notice: 'user was successfully updated.'
    else
      render :edit 
    end
  end

  def destroy
    @user_address.destroy
    redirect_to user_addresses_url, notice: 'user was successfully destroyed.'
  end

  private
    def set_user_address
      @user_address = UserAddress.find(params[:id])
    end

    def user_address_params
      params.require(:user_address).permit(:user_id, :name, :mobile, :province, :city, :country, :detail)
    end
end
