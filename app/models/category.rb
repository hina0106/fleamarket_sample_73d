class Category < ApplicationRecord
  has_many :items
  has_ancestry
end

  validates :name, presence: true
end
