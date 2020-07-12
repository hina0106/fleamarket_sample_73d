require 'rails_helper'
describe User do
  describe '#create' do

    # 1
    it "nickname、email、password、password_confirmation、first_name、family_name、first_name_kana、family_name_kana、birthdayが存在すれば登録できること" do
      expect(build(:user)).to be_valid
    end

    # 2
    it "nicknameがない場合は登録できないこと" do
      user = build(:user, nickname: nil)
      user.valid?
      expect(user.errors[:nickname]).to include("can't be blank")
    end

    # 3
    it "emailがない場合は登録できないこと" do 
      user = build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end

    # 4
    it "passwordがない場合は登録できないこと" do 
      user = build(:user, password: nil)
      user.valid?
      expect(user.errors[:password]).to include("can't be blank")
    end

    # 5
    it "passwordが存在してもpassword_confirmationがない場合は登録できないこと" do 
      user = build(:user, password_confirmation: "")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("doesn't match Password")
    end

    # 6
    it "first_nameがない場合は登録できないこと" do 
      user = build(:user, first_name: nil)
      user.valid?
      expect(user.errors[:first_name]).to include("can't be blank")
    end

    # 7
    it "family_nameがない場合は登録できないこと" do 
      user = build(:user, family_name: nil)
      user.valid?
      expect(user.errors[:family_name]).to include("can't be blank")
    end

    # 8
    it "first_name_kanaがない場合は登録できないこと" do 
      user = build(:user, first_name_kana: nil)
      user.valid?
      expect(user.errors[:first_name_kana]).to include("can't be blank")
    end

    # 9
    it "family_name_kanaがない場合は登録できないこと" do 
      user = build(:user, family_name_kana: nil)
      user.valid?
      expect(user.errors[:family_name_kana]).to include("can't be blank")
    end

    # 10
    it "birthdayがない場合は登録できないこと" do 
      user = build(:user, birthday: nil)
      user.valid?
      expect(user.errors[:birthday]).to include("can't be blank")
    end

    # 11
    it "重複したemailが存在する場合登録できないこと" do
      user = create(:user)
      another_user = build(:user, email: user.email)
      another_user.valid?
      expect(another_user.errors[:email]).to include("has already been taken")
    end

    # 12
    it " passwordが7文字以上であれば登録できること " do
      user = build(:user, password: "0000000", password_confirmation: "0000000")
      expect(user).to be_valid
    end

    # 13
    it " passwordが6文字以下であれば登録できないこと " do
      user = build(:user, password: "000000", password_confirmation: "000000")
      user.valid?
      expect(user.errors[:password]).to include("is too short (minimum is 7 characters)")
    end

    # 14
    it " first_nameが全角であれば登録できること " do
      user = build(:user, first_name: "あ")
      expect(user).to be_valid
    end

    # 15
    it " family_nameが全角であれば登録できること " do
      user = build(:user, family_name: "あ")
      expect(user).to be_valid
    end

    # 16
    it " first_name_kanaが全角であれば登録できること " do
      user = build(:user, first_name_kana: "あ")
      expect(user).to be_valid
    end

    # 17
    it " family_name_kanaが全角であれば登録できること " do
      user = build(:user, family_name_kana: "あ")
      expect(user).to be_valid
    end

    # 18
    it " first_nameが全角以外であれば登録できないこと " do
      user = build(:user, first_name: "a")
      expect(user).to_not be_valid
    end

    # 19
    it " family_nameが全角以外であれば登録できないこと " do
      user = build(:user, family_name: "a")
      expect(user).to_not be_valid
    end

    # 20
    it " first_name_kanaが全角以外であれば登録できないこと " do
      user = build(:user, first_name_kana: "a")
      expect(user).to_not be_valid
    end

    # 21
    it " family_name_kanaが全角以外であれば登録できないこと " do
      user = build(:user, family_name_kana: "a")
      expect(user).to_not be_valid
    end
  end
end