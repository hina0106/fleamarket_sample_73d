# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(sign_up_params)

    # 1ページ目で入力した情報のバリデーションチェック
    unless @user.valid?
      flash.now[:alert] = @user.errors.full_messages
      render :new and return
    end

    # 1ページで入力した情報をsessionに保持させる
    session["devise.regist_data"] = {user: @user.attributes}
    session["devise.regist_data"][:user]["password"] = params[:user][:password]

    @sendingDestination = @user.build_sending_destination
    render :newSendingDestination
  end

  def createSendingDestination
    @user = User.new(session["devise.regist_data"]["user"])

    # 2ページ目で入力した住所情報のバリデーションチェック
    @sendingDestination = SendingDestination.new(sendingDestinationParams)
    unless @sendingDestination.valid?
      flash.now[:alert] = @sendingDestination.errors.full_messages
      render :newSendingDestination and return
    end

    # バリデーションチェックが完了した情報と、sessionで保持していた情報とあわせ、ユーザー情報として保存する
    @user.build_sending_destination(@sendingDestination.attributes)
    binding.pry
    @user.save

    # sessionを削除する
    session["devise.regist_data"]["user"].clear
    # ログインする
    sign_in(:user, @user)
  end

  protected

  def sendingDestinationParams
    params.require(:sending_destination).permit(:destination_first_name, :destination_family_name, :destination_first_name_kana, :destination_family_name_kana, :post_code, :prefecture_code, :city, :house_number, :building_name, :phone_number)
  end
end
