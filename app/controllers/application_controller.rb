class MissingUserToken < ::StandardError; end

class ApplicationController < ActionController::API
  include ActionController::MimeResponds
  include JsonWebTokenHelper

  rescue_from StandardError, with: :internal_server_error
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from MissingUserToken, with: :unauthorized

  def internal_server_error(error)
    render json: { error: error.message }, status: :internal_server_error
  end

  def current_user
    token = request.headers["HTTP_TOKEN"]
    decoded = JsonWebTokenHelper.decode(token) if token
    User.find_by(id: decoded["id"]) if token
  end

  def require_current_user
    raise MissingUserToken unless current_user
  end

  def not_found
    head :not_found
  end

  def unauthorized
    head :unauthorized
  end

  respond_to :json
end
