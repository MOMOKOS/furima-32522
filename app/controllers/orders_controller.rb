class OrdersController < ApplicationController
  before_action :set_order
  before_action :authenticate_user!
  before_action :redirect_to_root_path
  before_action :sold_out

  def index
    @order_destination = OrderDestination.new
  end

  def create
    @item = Item.find(params[:item_id])
    @order_destination = OrderDestination.new(order_destination_params)
    if @order_destination.valid?
      pay_item
      @order_destination.save
      redirect_to root_path
    else
      render action: :index
    end
  end

  private
  def set_order
    @item = Item.find(params[:item_id])
  end

  def redirect_to_root_path
    redirect_to root_path if current_user.id == @item.user_id
  end

  def sold_out
    if @item.order.present?
      redirect_to root_path
    end
  end

  def pay_item
      Payjp.api_key = ENV["PAYJP_SECRET_KEY"]  
      Payjp::Charge.create(
        amount: @item.price,  
        card: order_destination_params[:token],    
        currency: 'jpy'                 
      )
  end

  def order_destination_params
    params.require(:order_destination).permit(:post_code, :prefecture_id, :city, :address, :building_name, :phone_number).merge(user_id:current_user.id, item_id:params[:item_id], token:params[:token])
  end

end
