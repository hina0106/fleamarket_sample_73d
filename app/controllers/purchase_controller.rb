class PurchaseController < CardsController
  alias :super_show :show

  def show
    super_show()
    @send_info = SendingDestination.where(user_id: current_user.id)
    @pref = JpPrefecture::Prefecture.find @send_info[0].prefecture_code
    @item = Item.find(params[:id])
  end
end