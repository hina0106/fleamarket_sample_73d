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
            :trading_status, allow_blank: true, numericality: {only_integer: true}
  validates :name,
            :introduction,
            :category_id,
            :item_condition_id,
            :postage_payer_id,
            :prefecture_code,
            :preparation_day_id,
            :price,
            :size_id,
            :postage_type_id,
            :seller_id,
            presence: true

  validates_associated :item_imgs
  validates :item_imgs, presence: true
  has_many :comments

  def jpy
    "¥#{self.price.to_s(:delimited, delimiter: ',')}"
  end
  
end

#   belongs_to_active_hash :prefecture_code
#   belongs_to_active_hash :item_condition
#   belongs_to_active_hash :postage_payer
#   belongs_to_active_hash :postage_type
#   belongs_to_active_hash :prefecture_code
#   belongs_to_active_hash :size

#   validate :itemimages_presence
#   validates :name, :text, :category_id, :condition_id, :deliverycost_id, :pref_id, :delivery_days_id, :user_id, presence: true
#   validates :price, presence: true, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 }

#   has_many_attached :images

#    #imageのバリデーション
#    def itemimages_presence
#     if images.attached?
#       # inputに保持されているimagesがあるかを確認
#       if images.length > 10
#         errors.add(:image, '10枚まで投稿できます')
#       end
#     else
#       errors.add(:image, '画像がありません')
#     end
#   end
# end
