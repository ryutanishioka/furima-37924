class OrdersController < ApplicationController
  before_action :item_find, only: [:index, :create]

  def index
    @item = Item.find(params[:item_id])

    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(o_s_params)
    if @order_address.valid?
      pay_item
      @order_address.save
      redirect_to root_path
    else
      render :index
    end
  end

private

  def o_s_params
    params.require(:order_address).permit(:post_code, :prefecture_id, :city, :address, :building_name,
      :phone_number).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,
      card: o_s_params[:token],
      currency: 'jpy'
    )
  end

  def item_find
    @item = Item.find(params[:item_id])
  end

end
