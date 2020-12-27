require 'rails_helper'
RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
    @item.image = fixture_file_upload('app/assets/images/kuchibeni.png')
  end

  describe '商品出品機能' do
    it "image, name, price, description, category_id,status_id,cost_id,prefecture_id,day_idを入力すると、商品の出品ができる" do
      expect(@item).to be_valid
    end
    it "imageが空だと登録できない" do
      @item.image = nil
      @item.valid?
      expect(@item.errors.full_messages).to include "Image can't be blank"
    end
    it "nameが空だと登録できない" do
      @item.name = ""
      @item.valid?
      expect(@item.errors.full_messages).to include "Name can't be blank"
    end
    it "descriptionが空だと登録できない" do
      @item.description = ""
      @item.valid?
      expect(@item.errors.full_messages).to include "Description can't be blank"
    end
    it "category_idがないと登録できない" do
      @item.category_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include "Category Select"
    end
    it "status_idがないと登録できない" do
      @item.status_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include "Status Select"
    end
    it "cost_idがないと登録できない" do
      @item.cost_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include "Cost Select"
    end
    it "prefecture_idがないと登録できない" do
      @item.prefecture_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include "Prefecture Select"
    end
    it "day_idがないと登録できない" do
      @item.day_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include "Day Select"
    end
    it "priceが空だと登録できない" do
      @item.price = nil
      @item.valid?
      expect(@item.errors.full_messages).to include "Price can't be blank"
    end
    it "priceの範囲が¥300~¥9,999,999の間でないと登録できない" do
      @item.price = 299
      @item.valid?
      expect(@item.errors.full_messages).to include "Price Out of setting range"
    end
    it "priceの範囲が¥300~¥9,999,999の間でないと登録できない" do
      @item.price = 10000000
      @item.valid?
      expect(@item.errors.full_messages).to include "Price Out of setting range"
    end
    it "priceは半角数字でないと登録できない" do
      @item.price = "５００"
      @item.valid?
      expect(@item.errors.full_messages).to include "Price Half-width number"
    end
    it "priceは半角英数混合では登録できない" do
      @item.price = "1000yen"
      @item.valid?
      binding.pry
      expect(@item.errors.full_messages).to include "Price Half-width number"
    end
  end
end
