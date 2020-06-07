# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  include JsonWebTokenHelper
  # skip_before_action :verify_signed_out_user
  # before_action :require_current_user, only: :destroy
  respond_to :json

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    user = User.find_by(email: session_params[:email])
    if user.present? && user&.valid_password?(session_params[:password])
      payload = { id: user.id, email: user.email }
      auth_token = JsonWebTokenHelper.encode(payload)
      # sign_in user
      render json: { session: { token: auth_token } }, status: :ok
    else
      render json: { session: { token: nil } }, status: :ok
    end
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  private

  def session_params
    params
      .require(:session)
      .permit(:email, :password)
  end
end
