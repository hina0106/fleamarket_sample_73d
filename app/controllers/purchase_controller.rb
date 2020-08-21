class PurchaseController < CardsController
  alias :super_show :show

  def index
    super_show()
    @send_info = SendingDestination.where(user_id: current_user.id)
    pref = JpPrefecture::Prefecture.find 13
  end
end