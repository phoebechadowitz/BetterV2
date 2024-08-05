class ResetPasswordMailer < ApplicationMailer
    require 'jwt'
    require 'uri'
    def reset_password(user_email)
        @user = user_email.downcase
        expiration_date = Time.current + 30.minutes
        payload = { email: @user, expiration_date: expiration_date}

        hmac_secret = ENV['FORGOT_PASS_KEY']
        token = JWT.encode(payload, hmac_secret, 'HS256')
        Rails.logger.debug "Token: #{token}"
        linkable_token = token.tr('.', '~')
        @url = new_password_url(linkable_token)
        mail(to: @user, subject: 'Reset your Better password!')
    end
end
