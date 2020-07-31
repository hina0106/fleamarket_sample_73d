class Item < ApplicationRecord
  # extend ActiveHash::Associations::ActiveRecordExtensions
  # belongs_to_active_hash :prefecture_code
  # belongs_to_active_hash :item_condition
  # belongs_to_active_hash :postage_payer
  # belongs_to_active_hash :postage_type
  # belongs_to_active_hash :prefecture_code
  # belongs_to_active_hash :size
  
  validate :itemimages_presence
  validates :name, :text, :category_id, :condition_id, :deliverycost_id, :pref_id, :delivery_days_id, :user_id, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 }
  
  has_many_attached :images
  has_many :comments
  
  #imageのバリデーション
  # def itemimages_presence
  # if images.attached?
  # # inputに保持されているimagesがあるかを確認
  # if images.length > 10
  # errors.add(:image, '10枚まで投稿できます')
  # end
  # else
  # errors.add(:image, '画像がありません')
  # end
end