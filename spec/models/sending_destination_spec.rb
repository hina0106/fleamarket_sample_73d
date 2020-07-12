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
      expect(sendingDestination.errors[:destination_first_name]).to include("can't be blank")
    end

    # 3
    it "destination_family_nameがない場合は登録できないこと" do
      sendingDestination = build(:sending_destination, destination_family_name: nil)
      sendingDestination.valid?
      expect(sendingDestination.errors[:destination_family_name]).to include("can't be blank")
    end

    # 4
    it "destination_first_name_kanaがない場合は登録できないこと" do
      sendingDestination = build(:sending_destination, destination_first_name_kana: nil)
      sendingDestination.valid?
      expect(sendingDestination.errors[:destination_first_name_kana]).to include("can't be blank")
    end

    # 5
    it "destination_family_name_kanaがない場合は登録できないこと" do
      sendingDestination = build(:sending_destination, destination_family_name_kana: nil)
      sendingDestination.valid?
      expect(sendingDestination.errors[:destination_family_name_kana]).to include("can't be blank")
    end

    # 6
    it "post_codeがない場合は登録できないこと" do
      sendingDestination = build(:sending_destination, post_code: nil)
      sendingDestination.valid?
      expect(sendingDestination.errors[:post_code]).to include("can't be blank")
    end

    # 7
    it "prefecture_codeがない場合は登録できないこと" do
      sendingDestination = build(:sending_destination, prefecture_code: nil)
      sendingDestination.valid?
      expect(sendingDestination.errors[:prefecture_code]).to include("can't be blank")
    end

    # 8
    it "cityがない場合は登録できないこと" do
      sendingDestination = build(:sending_destination, city: nil)
      sendingDestination.valid?
      expect(sendingDestination.errors[:city]).to include("can't be blank")
    end

    # 9
    it "house_numberがない場合は登録できないこと" do
      sendingDestination = build(:sending_destination, house_number: nil)
      sendingDestination.valid?
      expect(sendingDestination.errors[:house_number]).to include("can't be blank")
    end

    # 11
    it "重複したphone_numberが存在する場合登録できないこと" do
      user = create(:user)
      another_user = build(:user, phone_number: user.phone_number)
      another_user.valid?
      expect(another_user.errors[:phone_number]).to include("has already been taken")
    end

  end
end