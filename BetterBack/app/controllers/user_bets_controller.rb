class UserBetsController < ApplicationController
  before_action :set_user_bet, only: %i[ show edit update destroy ]

  # GET /user_bets
  def index
    @user_bets = UserBet.all
  end

  # GET /user_bets/1
  def show
  end

  # GET /user_bets/new
  def new
    @user_bet = UserBet.new
  end

  # GET /user_bets/1/edit
  def edit
  end

  # POST /user_bets
  def create
    @user_bet = UserBet.new(user_bet_params)

    if @user_bet.save
      redirect_to @user_bet, notice: "User bet was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /user_bets/1
  def update
    if @user_bet.update(user_bet_params)
      redirect_to @user_bet, notice: "User bet was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /user_bets/1
  def destroy
    @user_bet.destroy!
    redirect_to user_bets_url, notice: "User bet was successfully destroyed.", status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_bet
      @user_bet = UserBet.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_bet_params
      params.require(:user_bet).permit(:user_id, :bet_id)
    end
end
