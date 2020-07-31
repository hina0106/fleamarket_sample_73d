class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :sending_destination, dependent: :destroy
  has_many :comments

  validates :nickname,
            :email,
            :birthday, presence: true
  devise    :validatable, password_length: 7..128
  validates :family_name, presence: true, presence: {message: '姓を入力してください'}
  validates :first_name, presence: true, presence: {message: '名を入力してください'}
  validates :family_name_kana, presence: true, presence: {message: '姓カナを入力してください'}
  validates :first_name_kana, presence: true, presence: {message: '名カナを入力してください'}
  validates :email, uniqueness: true
  validates :first_name,
            :family_name,
            :first_name_kana,
            :family_name_kana,
            format: {
              with: /[^ -~｡-ﾟ]+/,
              message: '全角で入力してください'
            }
end
