require 'rails_helper'

RSpec.describe Item, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  describe '#create' do
    #1
    it "必須項目が全て存在すれば登録できること" do
      expect(build(:item)).to be_valid
    end

    # 2
    it "nameがない場合は登録できないこと" do
      item = build(:item, name: nil)
      item.valid?
      expect(item.errors[:name]).to include("必須入力です")
    end

    # 3
    it "introductionがない場合は登録できないこと" do
      item = build(:item, introduction: nil)
      item.valid?
      expect(item.errors[:introduction]).to include("必須入力です")
    end

    # 4
    it "priceがない場合は登録できないこと" do
      item = build(:item, price: nil)
      item.valid?
      expect(item.errors[:price]).to include("必須入力です")
    end

    # 5
    it "item_condition_idがない場合は登録できないこと" do
      item = build(:item, item_condition_id: nil)
      item.valid?
      expect(item.errors[:item_condition_id]).to include("必須入力です")
    end

    # 6
    it "postage_payer_idがない場合は登録できないこと" do
      item = build(:item, postage_payer_id: nil)
      item.valid?
      expect(item.errors[:postage_payer_id]).to include("必須入力です")
    end

    # 7
    it "prefecture_codeがない場合は登録できないこと" do
      item = build(:item, prefecture_code: nil)
      item.valid?
      expect(item.errors[:prefecture_code]).to include("必須入力です")
    end

    # 8
    it "size_idがない場合は登録できないこと" do
      item = build(:item, size_id: nil)
      item.valid?
      expect(item.errors[:size_id]).to include("必須入力です")
    end

    # 9
    it "preparation_day_idがない場合は登録できないこと" do
      item = build(:item, preparation_day_id: nil)
      item.valid?
      expect(item.errors[:preparation_day_id]).to include("必須入力です")
    end

    # 10
    it "postage_type_idがない場合は登録できないこと" do
      item = build(:item, postage_type_id: nil)
      item.valid?
      expect(item.errors[:postage_type_id]).to include("必須入力です")
    end

    # 11
    it "category_idがない場合は登録できないこと" do
      item = build(:item, category_id: nil)
      item.valid?
      expect(item.errors[:category_id]).to include("必須入力です")
    end

    # 12
    it "seller_idがない場合は登録できないこと" do
      item = build(:item, seller_id: nil)
      item.valid?
      expect(item.errors[:seller_id]).to include("必須入力です")
    end

  end
end
