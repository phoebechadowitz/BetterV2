class UsersController < ApplicationController
  require 'jwt'
  before_action :set_user, only: %i[ show update destroy ]

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
    email = params[:email]
    user = user.find_by(email: email)
    if user.nil? 
      render json: {error: "No user was found with that email"}
    end
    ResetPasswordMailer.with(user: user).reset_password.deliver_now
  end

  def reset_password
  end

  def edit
    token = params[:token]
    hmac_secret = 'my$ecretK3y'
    decoded_token = JWT.decode token, hmac_secret, true, { algorithm: 'HS256' }
    expiration_date = decoded_token[:expiration_date]
    email = decoded_token[:email]
    unless Time.current > expiration_date do
      @user = User.find_by(email: email)
    end
    render html: "This reset password link has expired"
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

end
