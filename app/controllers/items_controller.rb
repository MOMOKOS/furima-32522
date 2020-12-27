class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  def index
    @items = Item.all
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def item_params
    params.require(:item).permit(:name, :price, :description, :category_id, :status_id, :cost_id, :prefecture_id, :day_id, :image).merge(user_id: current_user.id)
  end
end
