require "test_helper"

class UserBetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_bet = user_bets(:one)
  end

  test "should get index" do
    get user_bets_url
    assert_response :success
  end

  test "should get new" do
    get new_user_bet_url
    assert_response :success
  end

  test "should create user_bet" do
    assert_difference("UserBet.count") do
      post user_bets_url, params: { user_bet: { bet_id: @user_bet.bet_id, user_id: @user_bet.user_id } }
    end

    assert_redirected_to user_bet_url(UserBet.last)
  end

  test "should show user_bet" do
    get user_bet_url(@user_bet)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_bet_url(@user_bet)
    assert_response :success
  end

  test "should update user_bet" do
    patch user_bet_url(@user_bet), params: { user_bet: { bet_id: @user_bet.bet_id, user_id: @user_bet.user_id } }
    assert_redirected_to user_bet_url(@user_bet)
  end

  test "should destroy user_bet" do
    assert_difference("UserBet.count", -1) do
      delete user_bet_url(@user_bet)
    end

    assert_redirected_to user_bets_url
  end
end
