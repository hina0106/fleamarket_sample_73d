class SendingDestination < ApplicationRecord
  belongs_to :user, optional: true

  validates :destination_first_name,
            :destination_family_name,
            :destination_first_name_kana,
            :destination_family_name_kana,
            :post_code,
            :prefecture_code,
            :city,
            :house_number,
            presence: true
  validates :phone_number, uniqueness: true
end
