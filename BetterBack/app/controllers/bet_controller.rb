class BetsController < ApplicationController
  def index
    render json: @user.bets
  end


  def create
    @bet = Bet.new(bet_params)
    if @bet.save
      render json: @bet, status: :created, location: @bet
    else
      render json: @bet.errors, status: :unprocessable_entity
    end
  end

  def update
    @bet = Bet.find(params[:id])
    if @bet.update(bet_params)
      render json: @user
    else
      render json: @bet.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @bet = Bet.find(params[:id])
    @bet.destroy
  end

  private

  def bet_params
    params.require(:bet).permit(:title, :description, :stakes)
  end
end

