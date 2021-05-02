# frozen_string_literal: true

class AuthenticationController < ApplicationController
  def authenticate_user
    user = User.find_for_database_authentication(email: params[:email])
    if user&.valid_password?(params[:password])
      render json: payload(user)
    else
      render json: { errors: ['Invalid Username/Password'] }, status: :unauthorized
    end
  end

  private

  def payload(user)
    return nil unless user && user.id

    {
      auth_token: JsonWebToken.encode(jwt_token(user)),
      user: { id: user.id, email: user.email, username: user.username }
    }
  end

  def jwt_token(user)
    {
      iss: Rails.application.config.auth_token_issuer,
      exp: (DateTime.now + 30.days).to_time.to_i,
      sub: user.id
    }
  end
end
