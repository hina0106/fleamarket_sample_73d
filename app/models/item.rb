class Item < ApplicationRecord
  def show
    @item = Item.find(params[:id])
  end
end
