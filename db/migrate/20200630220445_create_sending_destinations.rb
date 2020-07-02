class CreateSendingDestinations < ActiveRecord::Migration[5.2]
  def change
    create_table :sending_destinations do |t|
      t.integer :post_code, null: false
      t.timestamps
    end
  end
end
