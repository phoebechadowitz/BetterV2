require "application_system_test_case"

class UserBetsTest < ApplicationSystemTestCase
  setup do
    @user_bet = user_bets(:one)
  end

  test "visiting the index" do
    visit user_bets_url
    assert_selector "h1", text: "User bets"
  end

  test "should create user bet" do
    visit user_bets_url
    click_on "New user bet"

    fill_in "Bet", with: @user_bet.bet_id
    fill_in "User", with: @user_bet.user_id
    click_on "Create User bet"

    assert_text "User bet was successfully created"
    click_on "Back"
  end

  test "should update User bet" do
    visit user_bet_url(@user_bet)
    click_on "Edit this user bet", match: :first

    fill_in "Bet", with: @user_bet.bet_id
    fill_in "User", with: @user_bet.user_id
    click_on "Update User bet"

    assert_text "User bet was successfully updated"
    click_on "Back"
  end

  test "should destroy User bet" do
    visit user_bet_url(@user_bet)
    click_on "Destroy this user bet", match: :first

    assert_text "User bet was successfully destroyed"
  end
end
