class AddColumnItems < ActiveRecord::Migration[5.2]
  def change
    add_reference :items, :brand, foreign_key: true
    add_column :items, :size_id, :integer, null: false
    add_column :items, :item_condition_id, :integer, null: false
    add_column :items, :postage_payer_id, :integer, null: false
    add_column :items, :preparation_day_id, :integer, null: false
    add_column :items, :postage_type_id, :integer, null: false
    add_reference :items, :category, foreign_key: true, null: false
    add_reference :items, :seller, foreign_key: { to_table: :users }, null: false
    add_reference :items, :buyer, foreign_key: { to_table: :users }
    add_column :items, :trading_status, :integer, null: false, default: 0
  end
end
