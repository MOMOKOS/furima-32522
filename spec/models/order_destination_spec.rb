require 'rails_helper'

RSpec.describe OrderDestination, type: :model do
  describe '商品購入機能' do
    before do
        @item = FactoryBot.build(:item)
        @item.image = fixture_file_upload('app/assets/images/kuchibeni.png')
        @item.save
        @user = FactoryBot.create(:user)
        @order_destination = FactoryBot.build(:order_destination, user_id: @user.id, item_id: @item.id)
        sleep 0.1 # 0.1秒待機
    end

    context '商品購入ができる時' do
      it '必要事項を入力すると、商品の購入ができる' do
        expect(@order_destination).to be_valid
      end
      it 'building_nameがなくても登録できる' do
        @order_destination.building_name = ""
        expect(@order_destination).to be_valid
      end
    end

    context '商品購入ができない時' do
      it 'post_codeがないと登録できない' do
        @order_destination.post_code = ""
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include "Post code can't be blank"
      end
      it 'post_codeにハイフンが入っていないと登録できない' do
        @order_destination.post_code = "3333333"
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include "Post code Input correctly"
      end
      it 'prefecture_idが1以外でないと登録できない' do
        @order_destination.prefecture_id = 1
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include "Prefecture Select"
      end
      it 'cityがないと登録できない' do
        @order_destination.city = ""
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include "City can't be blank"
      end
      it 'addressがないと登録できない' do
        @order_destination.address = ""
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include "Address can't be blank"
      end
      it 'phone_numberがないと登録できない' do
        @order_destination.phone_number = ""
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include "Phone number can't be blank"
      end
      it 'phone_numberはハイフンがあると登録できない' do
        @order_destination.phone_number = "000-0000-00"
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include "Phone number  Input only number"
      end
      it 'phone_numberは11桁以上であれば登録できない' do
        @order_destination.phone_number = "111222333444555"
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include "Phone number is too long (maximum is 11 characters)"
      end
      it "tokenが空では登録できない" do
        @order_destination.token = nil
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
