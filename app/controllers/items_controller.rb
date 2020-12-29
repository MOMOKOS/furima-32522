class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :move_to_index, except: [:index, :show, :new, :create]

  def index
    @items = Item.order('created_at DESC')
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
    @item.destroy
    redirect_to root_path
  end

  private

  def item_params
    params.require(:item).permit(:name, :price, :description, :category_id, :status_id, :cost_id, :prefecture_id, :day_id,
                                 :image).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def move_to_index
    @item = Item.find(params[:id])
    redirect_to action: :index unless current_user.id == @item.user_id
  end
end
