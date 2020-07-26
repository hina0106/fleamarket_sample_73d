require 'faker'
FactoryBot.define do
  factory :item_img do
    item_id {create(:item).id}
    url   {"item.jpg"}
  end
end
