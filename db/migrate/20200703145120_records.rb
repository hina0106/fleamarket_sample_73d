class Records < ActiveRecord::Migration[5.2]
  change_column_default :items, :trading_status, from: nil, to: 0
end
