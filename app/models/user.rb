class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :sending_destination, dependent: :destroy

  validates :email, uniqueness: true, presence: true
  devise :validatable, password_length: 7..128
  validates :first_name,
            :family_name,
            :first_name_kana,
            :family_name_kana,
            format: {
              with: /[^ -~｡-ﾟ]+/
            }, allow_blank: true
  validates :nickname,
            :first_name,
            :family_name,
            :first_name_kana,
            :family_name_kana,
            :birthday, presence: true
end
