require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end
  describe "新規登録/ユーザー情報" do
    context "新規登録できる場合" do
      it "全ての値が正しく入力されていれば登録できる" do
        expect(@user).to be_valid
      end
    end
    context "新規登録できないとき" do
      it "ニックネームが空の場合登録できない" do
        @user.nickname = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank") 
      end
      it "メールアドレスが空の場合は登録できない" do
        @user.email = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it "メールアドレスが重複した場合は登録できない" do
        @user.save
        user2 = FactoryBot.build(:user)
        user2.email = @user.email
        user2.valid?
        expect(user2.errors.full_messages).to include("Email has already been taken")
      end
      it "メールアドレスは、@がない場合登録できない" do
        @user.email = "test.com"
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end
      it "パスワードが空の場合は登録できない" do
        @user.password = ""
        @user.valid?
        expect(@user.errors.full_messages).to include ("Password can't be blank")
      end
      it "パスワードとパスワード（確認）が不一致の場合は登録できない" do
        @user.password_confirmation = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it "パスワードが５文字以下の場合は登録できない" do
        @user.password = "aaaaa"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end
      it "passwordが129文字以上では登録できない" do
        @user.password = Faker::Lorem.characters(number: 129, min_alpha: 1, min_numeric: 1)
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too long (maximum is 128 characters)")
      end
      it "パスワードは、半角英字のみでは登録できない" do
        @user.password = "aaaaaa"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid")
      end
      it "パスワードは、半角数字のみでは登録できない" do
        @user.password = "123456"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid")
      end
      it "パスワードは、全角文字を含むと登録できない" do
        @user.password = "ａaaaaa"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid")
      end
    end
  end

  describe "新規登録/本人情報確認" do
    it "お名前(全角)の、名字が空の場合は登録できない" do
      @user.first_name = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end
    it "お名前(全角)の、名前が空の場合は登録できない" do
      @user.last_name = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end
    it "お名前(全角)の名字は、全角（漢字・ひらがな・カタカナ）以外では登録できない" do
      @user.first_name = "yamada"
      @user.valid?
      expect(@user.errors.full_messages).to include("First name is invalid")
    end
    it "お名前(全角)の名前は、全角（漢字・ひらがな・カタカナ）以外では登録できない" do
      @user.last_name = "tarou"
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name is invalid")
    end
    it "お名前カナ(全角)の、名字が空の場合は登録できない" do
      @user.first_name_kana = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("First name kana can't be blank")
    end
    it "お名前カナ(全角)の、名前が空の場合は登録できない" do
      @user.last_name_kana = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name kana can't be blank")
    end
    it "お名前カナ(全角)の名字は、全角（カタカナ）以外では登録できない" do
      @user.first_name_kana = "山田"
      @user.valid?
      expect(@user.errors.full_messages).to include("First name kana is invalid")
    end
    it "お名前カナ(全角)の名前は、全角（カタカナ）以外では登録できない" do
      @user.last_name_kana = "たろう"
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name kana is invalid")
    end
    it "生年月日が空の場合は登録できない" do
      @user.birth_day = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Birth day can't be blank")
    end
  end
end
