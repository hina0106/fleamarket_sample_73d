require 'faker'
FactoryBot.define do

  factory :sending_destination do
    Faker::Config.locale = :ja

    destination_first_name        {Faker::Japanese::Name.first_name}
    destination_family_name       {Faker::Japanese::Name.last_name}
    destination_first_name_kana   {Faker::Japanese::Name.first_name.yomi}
    destination_family_name_kana  {Faker::Japanese::Name.last_name.yomi}
    post_code                     {"0000000"}
    prefecture_code               {"00"}
    city                          {Faker::Address.city}
    house_number                  {"0"}
    user
  end

end