require 'faker'
FactoryBot.define do
  factory :item_img do
    # item_id {create(:item).id}
    url   {File.open("#{Rails.root}/public/images/test_image.jpg")}
  end
end
