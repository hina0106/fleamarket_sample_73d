FactoryBot.define do
  factory :category do
  name     {Faker::Commerce.material}
  ancestry {nil}
  end
end
