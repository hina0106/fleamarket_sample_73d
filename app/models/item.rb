class Item < ApplicationRecord

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :item_conditions
  belongs_to_active_hash :prefecture_code
  belongs_to_active_hash :Postage_payers
  belongs_to_active_hash :Preparation_days
  #belongs_to_active_hash :boughtflg
  # 上記active_hashのアソシエーション
  validate :images_presence
  validates :name, :text, :category_id, :item_condition_id, :Postage_payers_id, :prefecture_code_id, :Preparation_days_id, :boughtflg_id,:user_id, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 }

  has_many_attached :images
  belongs_to :user, foreign_key: 'user_id'
 # optional: true後で消す。belongs_toのnotnull制約解放のため使用している
  belongs_to :category

  #imageのバリデーション
  def images_presence
    if images.attached?
      # inputに保持されているimagesがあるかを確認
      if images.length > 10
        errors.add(:image, '10枚まで投稿できます')
      end
    else
      errors.add(:image, '画像がありません')
    end
  end
end
