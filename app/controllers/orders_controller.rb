class OrdersController < ApplicationController

  def index
    @order = Order.new
    @item = Item.find(params[:item_id])

    @order_address = OrderAddress.new
  end

  def create
    @item = Item.find(params[:item_id])
    @order_address = OrderAddress.new(o_s_params)
    if @order_address.valid?
      @order_address.save
      redirect_to root_path
    else
      render :index
    end
  end

private

  def o_s_params
    params.require(:order_address).permit(:post_code, :prefecture_id, :city, :address, :building_name, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id])
  end
end
