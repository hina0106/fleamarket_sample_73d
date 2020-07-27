require 'faker'
FactoryBot.define do
  factory :item_img do
    url   {"spec/fixtures/test_image.png"}
  end
end
