class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture_code
  belongs_to_active_hash :item_condition
  belongs_to_active_hash :postage_payer
  belongs_to_active_hash :postage_type
  belongs_to_active_hash :prefecture_code
  belongs_to_active_hash :size

  validates :name, :text, :category_id, :condition_id, :deliverycost_id, :pref_id, :delivery_days_id, :user_id, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 }
end