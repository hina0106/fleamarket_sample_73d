require 'faker'
FactoryBot.define do

  factory :user do
    password = Faker::Internet.password(min_length: 7)

    nickname              {Faker::JapaneseMedia::OnePiece.character}
    sequence(:email)      {Faker::Internet.email}
    password              {password}
    password_confirmation {password}
    first_name            {Faker::Japanese::Name.first_name}
    family_name           {Faker::Japanese::Name.last_name}
    first_name_kana       {Faker::Japanese::Name.first_name.yomi}
    family_name_kana      {Faker::Japanese::Name.last_name.yomi}
    birthday              {Faker::Date.birthday(min_age: 18, max_age: 80)}
  end

end