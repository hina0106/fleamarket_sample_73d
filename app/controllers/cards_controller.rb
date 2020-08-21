class CardsController < ApplicationController

  def index
  end

  def new
    @card = CreditCard.new
  end

  def create
    # トークンをPAYJP側に送信し、顧客IDを取得する
    # PAYJPと通信できるように設定
    Payjp.api_key = Rails.application.credentials.payjp[:secret_key]
    # PAYJPのメソッドを用いて顧客IDを生成・取得
    customer = Payjp::Customer.create(
      card: params[:card_token]
    )
    
    # 取得した情報でインスタンス作成
    @card = CreditCard.new(
      card_id: customer.default_card,
      customer_id: customer.id,
      user_id: current_user.id
    )
    @card.save
    redirect_to card_path(current_user.id)
  end

  def show
    @card = CreditCard.where(user_id: current_user.id).first
    unless @card.blank?
      Payjp.api_key = Rails.application.credentials.payjp[:secret_key]
      customer = Payjp::Customer.retrieve(@card.customer_id)
      @card_information = customer.cards.retrieve(@card.card_id)
    end
  end

  def destroy
    card = CreditCard.find(params[:id])
    Payjp.api_key = Rails.application.credentials.payjp[:secret_key]
    customer = Payjp::Customer.retrieve(card.customer_id)
    customer.delete
    card.delete
    redirect_to action: "show"
  end

end
