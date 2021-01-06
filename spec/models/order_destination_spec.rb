require 'rails_helper'

RSpec.describe OrderDestination, type: :model do
  describe '商品購入機能' do
    before do
        @order_destination = FactoryBot.build(:order_destination)
    end

    it 'post_code,prefecture_id,city,address,phone_number,user_id,item_id,tokenを入力すると、商品の購入ができる' do
      expect(@order_destination).to be_valid
    end
    it 'post_codeにハイフンが入っていないと登録できない' do
      @order_destination.post_code = "3333333"
      @order_destination.valid?
      expect(@order_destination.errors.full_messages).to include "Post code Input correctly"
    end
    it 'phone_numberはハイフンがあると登録できない' do
      @order_destination.phone_number = "000-0000-00"
      @order_destination.valid?
      expect(@order_destination.errors.full_messages).to include "Phone number  Input only number"
    end
    it 'phone_numberは11桁以内であれば登録できる' do
      @order_destination.phone_number = "111222333"
      expect(@order_destination).to be_valid
    end
    it "tokenが空では登録できないこと" do
      @order_destination.token = nil
      @order_destination.valid?
      expect(@order_destination.errors.full_messages).to include("Token can't be blank")
    end
  end
end
