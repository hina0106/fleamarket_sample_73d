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
    if @card.save
      flash[:notice] = 'クレジットカードの登録が完了しました'
      redirect_to new_card_path
    end
  end

  def show
    @cards = CreditCard.where(user_id: current_user.id)
  end

end
