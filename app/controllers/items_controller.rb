class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit]
  before_action :item_find, only: [:show, :edit, :update]
  before_action :redirect_to_index, only: [:edit]

  def index
    @items = Item.includes(:user).order("created_at DESC")
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path(@item)
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path
    else
      render :edit
    end
  end

  def destroy
  end

  private

  def item_params
    params.require(:item).permit(:name, :content, :price, :image, :category_id,
      :condition_id, :payment_id, :prefecture_id, :day_id).merge(user_id: current_user.id)
  end

  def redirect_to_index
    unless current_user.id == @item.user_id
      redirect_to root_path
    end
  end

  def item_find
    @item = Item.find(params[:id])
  end
end
