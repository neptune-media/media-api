# frozen_string_literal: true

class ApplicationController < ActionController::API
  attr_reader :current_user

  def authenticate_request!
    if !user_id_in_token? || token_expired?
      render json: { errors: ['Not Authenticated'] }, status: :unauthorized
      return
    end
    @current_user = User.find(auth_token[:sub])
  rescue JWT::VerificationError, JWT::DecodeError
    render json: { errors: ['Not Authenticated'] }, status: :unauthorized
  end

  private

  def http_token
    @http_token ||= (request.headers['Authorization'].split.last if request.headers['Authorization'].present?)
  end

  def auth_token
    @auth_token ||= JsonWebToken.decode(http_token)
  end

  def user_id_in_token?
    http_token && auth_token && auth_token[:sub].to_s
  end

  def token_expired?
    exp = auth_token[:exp].to_i
    DateTime.now.to_time.to_i > exp
  end
end
