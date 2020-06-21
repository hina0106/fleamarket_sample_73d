# README

# fleamarket_sample DB設計
## Categoriesテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|ancestry|string|null: false|
### Association
- has_many :Items
## Favoritesテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|reference|null: false, foreign_key: true|
|item_id|reference|null: false, foreign_key: true|
### Association
- belongs_to :user
- belongs_to :item
## Commentsテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|reference|null: false, foreign_key: true|
|item_id|reference|null: false, foreign_key: true|
|comment|text|null: false|
|created_at|timestamp|null: false|
### Association
- belongs_to :user
- belongs_to :item
## Sending_destination テーブル
|Column|Type|Options|
|------|----|-------|
|destination_first_name|string|null: false|
|destination_familly_name|string|null: false|
|destination_first_name_kana|string|null: false|
|destination_familly_name_kana|string|null: false|
|post_code|integer(7)|null: false|
|prefecture_code|integer|null: false|
|city|string|null:false|
|house_number|string|null:false|
|building_name|string| |
|phone_number|integer|unique:|true|
|user_id|references|null: false, foreign_key: true|
### Association
- belongs_to :user
- Gem：jp_prefectureを使用して都道府県コードを取得
## usersテーブル
|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false|
|password|string|null: false|
|email|string|null: false, unique: true, index:true|
### Association
- has_many :comments, dependent: :destroy
- has_many :favorites, dependent: :destroy
- has_many :todo_lists
- has_many :user_evaluations
- has_many :seller_items, foreign_key: “seller_id”, class_name: “items”
- has_many :buyer_items, foreign_key: “buyer_id”, class_name: “items”
- has_one :point
- has_one :profile, dependent: :destroy
- has_one :sns_authentication, dependent: :destroy
- has_one :sending_destination, dependent: :destroy
- has_one :credit_card, dependent: :destroy
## item_imgsテーブル
|Column|Type|Options|
|------|----|-------|
|url|string|null: false|
|item|references|null: false, foreign_key: true|
### Association
- belongs_to :item
## Profilesテーブル
|Column|Type|Options|
|------|----|-------|
|first_name|string|null: false|
|family_name|string|null: false|
|first_name_kana|string|null:false|
|family_name_kana|string|null:false|
|birth_year|date|null:false|
|birth_month|date|null:false|
|birth_day|date|null:false|
|introduction|text| |
|avatar|string| |
|user_id|references|null: false, foreign_key: true|
### Association
- belongs_to :user
## itemテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|introduction|text|null: false|
|price|integer|null: false|
|brand_id|references|foreign_key: true|
|item_condition_id|references|null: false,foreign_key: true|
|postage_payer_id|references|null: false,foreign_key: true|
|prefecture_code|integer|null: false|
|size_id|reference|null: false, foreign_key: true|
|preparation_day|references|null: false, foreign_key: true|
|postage_type|references|null: false, foreign_key: true|
|item_image_id|references|null: false, foreign_key: true|
|category_id|references|null: false, foreign_key: true|
|trading_status|enum|null: false|
|seller_id|references|null: false, foreign_key: true|
|buyer|reference|foreign_key: true|
|deal_close_date|timestamp|
### Association
- has_many :comments, dependent: :destroy
- has_many :favorites
- has_many :item_imgs, dependent: :destroy
- has_one :user_evaluation
- belongs_to :category
- belongs_to_active_hash :size
- belongs_to_active_hash :item_condition
- belongs_to_active_hash :postage_payer
- belongs_to_active_hash :preparation_day
- belongs_to_active_hash :postage_type
- belongs_to :brand
- belongs_to :seller, class_name: "User"
- belongs_to :buyer, class_name: "User"
- Gem：jp_prefectureを使用して都道府県コードを取得
## brandsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|
### Association
- has_many :items
## pointsテーブル
|Column|Type|Options|
|------|----|-------|
|point|integer||
|user_id|references|null: false, foreign_key: true|
### Association
- belongs_to :user
## sns_authentications テーブル
|Column|Type|Options|
|------|----|-------|
|provider|string|null: false|
|uld|string|null: false, unique: true|
|token|text| |
|user_id|references|null: false, foreign_key: true|
### Association
- belongs_to :user
## user_evaluationsテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|references|null: false, foreign_key: true|
|item_id|references|null: false, foreign_key: true|
|evaluation_id|references|null: false, foreign_key: true|
|review|text|null: false|
### Association
- belongs_to_active_hash:evaluation
- belongs_to :user
- belongs_to :item
## todo_listsテーブル
|Column|Type|Options|
|------|----|-------|
|list|text|null:false|
|user_id|references|null: false, foreign_key: true|
### Association
- belongs_to
## credit_cardsテーブル
|Column|Type|Options|
|------|----|-------|
|card_number|integer|null:false, unique: true|
|card_number|integer|null:false|
|expiration_year|integer|null:false|
|expiration_month|integer|null:false|
|security_code|integer|null:false|
|user_id|references|null: false, foreign_key: true|
### Association
- belongs_to :user