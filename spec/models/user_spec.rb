require 'rails_helper'
RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    it "nickname、email、password、password_confirmation、family_name、first_name、family_name_kana、first_name_kana、birth_dayが存在すれば登録できる" do
      expect(@user).to be_valid
    end
    it "nicknameが空だと登録できない" do
      @user.nickname = ""
      @user.valid?
      expect(@user.errors.full_messages).to include "Nickname can't be blank"
    end
    it "emailが空だと登録できない" do
      @user.email = ""
      @user.valid?
      expect(@user.errors.full_messages).to include "Email can't be blank"
    end
    it "重複したemailが存在する場合登録できない" do
      @user.save
      another_user = FactoryBot.build(:user, email: @user.email)
      another_user.valid?
      expect(another_user.errors.full_messages).to include("Email has already been taken")
    end
    it "emailが@を含んでいないと登録できない" do
      @user.email = "testgmail.com"
      @user.valid?
      expect(@user.errors.full_messages).to include "Email is invalid"
    end
    it "passwordが空だと登録できない" do
      @user.password = ""
      @user.valid?
      expect(@user.errors.full_messages).to include "Password can't be blank"
    end
    it "passwordが5文字以下では登録できない" do
      @user.password = "00000"
      @user.password_confirmation = "00000"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end
    it "passwordが半角数字のみの場合は登録できない" do
      @user.password = "111111"
      @user.password_confirmation = "111111"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password Include both letters and numbers")
    end
    it "passwordが半角英字のみの場合は登録できない" do
      @user.password = "testtesttest"
      @user.password_confirmation = "testtesttest"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password Include both letters and numbers")
    end
    it "passwordが存在してもpassword_confirmationが空では登録できない" do
      @user.password = "test1test1"
      @user.password_confirmation = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    it "passwordとpassword_confirmationの値が同一でなければ登録できない" do
      @user.password = "test1test1"
      @user.password_confirmation = "test2test2"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end 
    it "passwordが全角では登録できない" do
      @user.password = "ｔｅｓｔｔｅｓｔ１"
      @user.password_confirmation = "ｔｅｓｔｔｅｓｔ１"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password Include both letters and numbers")
    end
    it "本名はfamily_nameがなければ登録できない" do
      @user.family_name = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Family name can't be blank", "Family name Full-width characters")
    end
    it "本名はfirst_nameがなければ登録できない" do
      @user.first_name = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("First name can't be blank", "First name Full-width characters")
    end
    it "family_nameは全角（漢字・ひらがな・カタカナ）でなければ登録できない" do
      @user.family_name = "test"
      @user.valid?
      expect(@user.errors.full_messages).to include("Family name Full-width characters")
    end
    it "first_nameは全角（漢字・ひらがな・カタカナ）でなければ登録できない" do
      @user.first_name = "test"
      @user.valid?
      expect(@user.errors.full_messages).to include("First name Full-width characters")
    end
    it "本名はfamily_name_kanaがなければ登録できない" do
      @user.family_name_kana = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Family name kana can't be blank", "Family name kana Full-width katakana characters")
    end
    it "本名はfirst_name_kanaがなければ登録できない" do
      @user.first_name_kana = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("First name kana can't be blank", "First name kana Full-width katakana characters")
    end
    it "family_name_kanaは全角（カタカナ）でなければ登録できない" do
      @user.family_name_kana = "山田"
      @user.valid?
      expect(@user.errors.full_messages).to include("Family name kana Full-width katakana characters")
    end
    it "first_name_kanaは全角（カタカナ）でなければ登録できない" do
      @user.first_name_kana = "太郎"
      @user.valid?
      expect(@user.errors.full_messages).to include("First name kana Full-width katakana characters")
    end
    it "birth_dayが空だと登録できない" do
      @user.birth_day = ""
      @user.valid?
      expect(@user.errors.full_messages).to include "Birth day can't be blank"
    end
  end 
end


