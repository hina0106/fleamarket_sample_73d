class PurchaseController < CardsController
  alias :super_show :show

  def show
    super_show()
    @send_info = SendingDestination.where(user_id: current_user.id)
    @pref = JpPrefecture::Prefecture.find @send_info[0].prefecture_code
    @item = Item.find(params[:id])
  end

  def pay
    card = CreditCard.where(user_id: current_user.id).first
    unless card.blank?
      Payjp.api_key = Rails.application.credentials.payjp[:secret_key]
      Payjp::Charge.create(
        amount: params[:item_price], #支払金額
        customer: card.customer_id, #顧客ID
        currency: 'jpy' #日本円
      )
      Item.where(id: params[:item_id]).update(buyer_id: current_user.id, trading_status: 1)
    end
    redirect_to new_card_path
  end
end