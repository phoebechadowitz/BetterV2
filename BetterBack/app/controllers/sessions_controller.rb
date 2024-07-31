class SessionsController < ApplicationController
  require 'jwt'

  def create
    email = params[:email]
    password = params[:password]

    user = User.find_by(email: email.downcase)
    if user&.authenticate(params[:password])
      payload = { username: user.email }

      # The secret must be a string. A JWT::DecodeError will be raised if it isn't provided.
      hmac_secret = 'my$ecretK3y'

      @token = JWT.encode payload, hmac_secret, 'HS256'
      @decoded_token = JWT.decode @token, hmac_secret, true, { algorithm: 'HS256' }
      
      if (@token)
        render json: { token: @token, decoded_token: @decoded_token }
      else
        render json: {error: "error"}
      end
    else
      render json: {error: "error"}
    end
  end
end
