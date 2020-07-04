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
  
  def newSendingDestination
    @sendingDestination = SendingDestination.new
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
  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
