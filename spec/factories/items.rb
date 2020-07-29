require 'faker'
FactoryBot.define do
  factory :item do
    name               {Faker::Commerce.product_name}
    introduction       {Faker::Commerce.promotion_code}
    price              {Faker::Commerce.price}
    item_condition_id  {"1"}
    postage_payer_id   {"1"}
    prefecture_code    {"1"}
    size_id            {"1"}
    preparation_day_id {"1"}
    postage_type_id    {"1"}
    category_id        {create(:category).id}
    trading_status     {"0"}
    seller_id          {create(:user).id}
    after(:build) do |item|
      item.item_imgs << build(:item_img)
    end
  end
end
