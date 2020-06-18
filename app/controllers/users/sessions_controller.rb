# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  include JsonWebTokenHelper
  respond_to :json
  # skip_before_action :verify_signed_out_user
  # before_action :require_current_user, only: :destroy

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    @user = User.find_by(email: session_params[:email])
    if !@user&.confirmed?
      render json: { message: "Please complete your login process" }, status: :bad_request
    elsif !@user.has_role? session_params[:role]
      render json: { message: "Invalid Role selected" }, status: :bad_request
    elsif @user.present? && @user&.valid_password?(session_params[:password])
      payload = { id: @user.id, email: @user.email }
      @auth_token = JsonWebTokenHelper.encode(payload)
    else
      render json: { message: "Invalid Credentials" }, status: :bad_request
    end
  end

  # POST /resource/confirm_email
  def confirm_email
    @user = User.find_by(email: session_params[:email])
    unless @user.present?
      render json: { message: "Email not found" }, status: :bad_request
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
      .permit(:email, :password, :role)
  end
end
