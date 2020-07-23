class Item < ApplicationRecord
  belongs_to :brand
  has_many :item_img, dependent: :destroy
  belongs_to :category
  belongs_to_active_hash :size
  belongs_to_active_hash :item_condition
  belongs_to_active_hash :postage_payer
  belongs_to_active_hash :postage_type
  belongs_to_active_hash :preparation_day
end
