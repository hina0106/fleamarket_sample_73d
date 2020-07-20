require 'rails_helper'
describe SendingDestination do
  describe '#create' do
    # 1
    it "destination_first_name、destination_family_name、destination_first_name_kana、destination_family_name_kana、post_code、prefecture_code、city、house_numberが存在すれば登録できること" do
      sendingDestination = build(:sending_destination)
      expect(sendingDestination).to be_valid
    end

    # 2
    it "destination_first_nameがない場合は登録できないこと" do
      sendingDestination = build(:sending_destination, destination_first_name: nil)
      sendingDestination.valid?
      expect(sendingDestination.errors[:destination_first_name]).to include("名を入力してください")
    end

    # 3
    it "destination_family_nameがない場合は登録できないこと" do
      sendingDestination = build(:sending_destination, destination_family_name: nil)
      sendingDestination.valid?
      expect(sendingDestination.errors[:destination_family_name]).to include("姓を入力してください")
    end

    # 4
    it "destination_first_name_kanaがない場合は登録できないこと" do
      sendingDestination = build(:sending_destination, destination_first_name_kana: nil)
      sendingDestination.valid?
      expect(sendingDestination.errors[:destination_first_name_kana]).to include("名カナを入力してください")
    end

    # 5
    it "destination_family_name_kanaがない場合は登録できないこと" do
      sendingDestination = build(:sending_destination, destination_family_name_kana: nil)
      sendingDestination.valid?
      expect(sendingDestination.errors[:destination_family_name_kana]).to include("姓カナを入力してください")
    end

    # 6
    it "post_codeがない場合は登録できないこと" do
      sendingDestination = build(:sending_destination, post_code: nil)
      sendingDestination.valid?
      expect(sendingDestination.errors[:post_code]).to include("必須入力です")
    end

    # 7
    it "prefecture_codeがない場合は登録できないこと" do
      sendingDestination = build(:sending_destination, prefecture_code: nil)
      sendingDestination.valid?
      expect(sendingDestination.errors[:prefecture_code]).to include("必須入力です")
    end

    # 8
    it "cityがない場合は登録できないこと" do
      sendingDestination = build(:sending_destination, city: nil)
      sendingDestination.valid?
      expect(sendingDestination.errors[:city]).to include("必須入力です")
    end

    # 9
    it "house_numberがない場合は登録できないこと" do
      sendingDestination = build(:sending_destination, house_number: nil)
      sendingDestination.valid?
      expect(sendingDestination.errors[:house_number]).to include("必須入力です")
    end

    # # 10
    # it "post_codeが半角数字以外の場合は登録できないこと" do
    #   sendingDestination = build(:sending_destination, post_code: "０")
    #   sendingDestination.valid?
    #   expect(sendingDestination.errors[:post_code]).to include("半角数字で入力してください")
    # end

    # # 11
    # it "phone_numberが半角数字以外の場合は登録できないこと" do
    #   sendingDestination = build(:sending_destination, phone_number: "０")
    #   sendingDestination.valid?
    #   expect(sendingDestination.errors[:phone_number]).to include("半角数字で入力してください")
    # end
  end
end