class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  include JpPrefecture
  jp_prefecture :prefecture_code

  belongs_to :brand, optional: true
  has_many :item_imgs, dependent: :destroy
  belongs_to :category
  belongs_to_active_hash :size
  belongs_to_active_hash :item_condition
  belongs_to_active_hash :postage_payer
  belongs_to_active_hash :postage_type
  belongs_to_active_hash :preparation_day
  belongs_to :seller, class_name: "User"
  belongs_to :buyer, class_name: "User", optional: true
  accepts_nested_attributes_for :item_imgs, allow_destroy: true, update_only: true

  validates :brand_id,
            :buyer_id,
            :trading_status, allow_blank: true, numericality: {only_integer: true}

end
