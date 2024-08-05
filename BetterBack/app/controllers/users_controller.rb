class UsersController < ApplicationController
  require 'jwt'
  skip_before_action :verify_authenticity_token
  before_action :set_user, only: %i[ show update destroy ]
  before_action :decode_password_token, only: %i[ edit_password reset_password]

  # GET /users
  def index
    @users = User.all

    render json: @users
  end

  # GET /users/1
  def show
    render json: @user
  end

  # POST /users
  def create
    email = params[:user][:email].downcase
    password = params[:user][:password]
    confirmation = params[:user][:confirmation]
    @user = User.new(email: email, password: password, password_confirmation: confirmation)

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy!
  end

  def forgot_password
    email = params[:email].downcase
    user = User.find_by(email: email)

    if user.nil?
      render json: { message: "No user was found with that email" }, status: :not_found
    else
      ResetPasswordMailer.reset_password(email).deliver_now
      render json: { message: "Password reset instructions have been sent to #{email}" }, status: :ok
    end
  end


  def reset_password
    new_password = params[:user][:password]
    new_password_confirmation = params[:user][:password_confirmation]
    if (new_password == new_password_confirmation)
      if @user.update(password: new_password, password_confirmation: new_password_confirmation)
        render html: "Password was successfully updated"
      else
        render html: "There was an error updating your password"
      end
    else
      render html: "Password and confirmation do not match" 
    end
  end



  def edit_password
    if @user
      render :edit
    else
      render html: "User not found." 
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end

    def decode_password_token
      @linkable_token = params[:token]
      hmac_secret = ENV['FORGOT_PASS_KEY']
      unlinked_token = @linkable_token.tr('~', '.')
      decoded_token = JWT.decode unlinked_token, hmac_secret, true, { algorithm: 'HS256' }
      payload = decoded_token.first
      expiration_date_str = payload['expiration_date']
      @expiration_date = Time.parse(expiration_date_str)
      email = payload['email'].downcase
      @user = User.find_by(email: email)

      if Time.current > @expiration_date
        render html: "The reset link has expired."
      end
      rescue JWT::DecodeError => e
        render html: "Invalid reset link."
    end

end
