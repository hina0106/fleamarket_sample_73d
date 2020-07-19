class SendingDestination < ApplicationRecord
  belongs_to :user, optional: true

  include JpPrefecture
  jp_prefecture :prefecture_code

  # post_codeからprefecture_nameに変換
  def prefecture_name
    JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
  end
    
  def prefecture_name=(prefecture_name)
    self.prefecture_code = JpPrefecture::Prefecture.find(name: prefecture_name).code
  end

  validates :post_code,
            :prefecture_code,
            :city,
            :house_number,
            presence: true
  validates :destination_family_name, presence: true, presence: {message: '姓を入力してください'}
  validates :destination_first_name, presence: true, presence: {message: '名を入力してください'}
  validates :destination_family_name_kana, presence: true, presence: {message: '姓カナを入力してください'}
  validates :destination_first_name_kana, presence: true, presence: {message: '名カナを入力してください'}
  # validates :phone_number,
  #           :post_code,
  #           format: {
  #             with: /[0-9]+/,
  #             message: '半角数字で入力してください'
  #           }
end
