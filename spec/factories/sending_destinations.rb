FactoryBot.define do

  factory :sending_destination do
    destination_first_name        {"田中"}
    destination_family_name       {"花子"}
    destination_first_name_kana   {"タナカ"}
    destination_family_name_kana  {"ハナコ"}
    post_code                     {"0000000"}
    prefecture_code               {"00"}
    city                          {"テスト市"}
    house_number                  {"0000000000"}
    user
  end

end