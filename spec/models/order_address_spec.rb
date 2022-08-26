require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  describe "商品購入情報の保存" do
    before do
      @user = FactoryBot.create(:user)
      @item = FactoryBot.create(:item)
      @order_address = FactoryBot.build(:order_address, user_id: @user.id, item_id: @item.id) 
      sleep 0.1
    end

    context "正常に保存できる場合" do
      it "全ての値が正しく入力されていれば保存できる" do
        expect(@order_address).to be_valid
      end
      it "building_nameは入力しなくても保存できる" do
        @order_address.building_name = ""
        expect(@order_address).to be_valid
      end
    end

    context "問題があり保存できない場合" do
      it "post_codeが空の場合保存できない" do
        @order_address.post_code = ""
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Post code can't be blank")
      end
      it "post_codeが半角のハイフンを含んだ正しい形式でないと保存できない" do
        @order_address.post_code = 1112222
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Post code is invalid. Include hyphen(-)")
      end
      it "prefectureを選択していないと保存できない" do
        @order_address.prefecture_id = 1
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Prefecture can't be blank")
      end
      it "cityが空の場合保存できない" do
        @order_address.city = ""
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("City can't be blank")
      end
      it "addressが空の場合保存できない" do
        @order_address.address = ""
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Address can't be blank")
      end
      it "phone_numberが空の場合保存できない" do
        @order_address.phone_number = ""
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number can't be blank")
      end
      it "phone_numberはハイフンを含むと登録できない" do
        @order_address.phone_number = "090-1111-2222"
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number is invalid. not hyphen")
      end
      it "phone_number9桁以下の場合は登録できない" do
        @order_address.phone_number = "123456789"
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number is too short (minimum is 10 characters)")
      end
      it "phone_number12桁以上の場合は登録できない" do
        @order_address.phone_number = "012345678912"
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number is too long (maximum is 11 characters)")
      end
      it "userが紐付いていないと保存できないこと" do
        @order_address.user_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("User can't be blank")
      end
      it "itemが紐付いていないと保存できないこと" do
        @order_address.item_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end
