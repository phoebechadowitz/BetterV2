class ResetPasswordMailer < ApplicationMailer
    require 'jwt'
    def reset_password
        @user = params[:user]
        expiration_date = Time.current + 30.minutes
        payload = { email: user.email, expiration_date: expiration_date, cause: "password reset"}

        hmac_secret = 'my$ecretK3y'

        token = JWT.encode payload, hmac_secret, 'HS256'
        @url  = reset_password_url(token)
        mail(to: @user.email, subject: 'Reset your Better password!')
    end
end
