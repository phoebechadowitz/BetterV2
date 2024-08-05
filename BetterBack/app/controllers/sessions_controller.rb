class SessionsController < ApplicationController
  require 'jwt'
 skip_before_action :verify_authenticity_token

  def create
    email = params[:email]
    password = params[:password]

    user = User.find_by(email: email.downcase)
    if user&.authenticate(params[:password])
      payload = { username: user.email }

      # The secret must be a string. A JWT::DecodeError will be raised if it isn't provided.
      hmac_secret = ENV['JWT_KEY']

      @token = JWT.encode payload, hmac_secret, 'HS256'
      @decoded_token = JWT.decode @token, hmac_secret, true, { algorithm: 'HS256' }
      
      if (@token)
        render json: { token: @token, email: email.downcase }
      else
        render json: {error: "Internal server error, please try again"}
      end
    else
      render json: {error: "User could not be found. Make sure you entered the correct email and password"}
    end
  end
end
