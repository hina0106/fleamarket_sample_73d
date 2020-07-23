class Item < ApplicationRecord
  belongs_to :brand
  has_many :item_img, dependent: :destroy
  belongs_to :category
end
