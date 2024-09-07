require "application_system_test_case"

class GameUsersTest < ApplicationSystemTestCase
  setup do
    @game_user = game_users(:one)
  end

  test "visiting the index" do
    visit game_users_url
    assert_selector "h1", text: "Game users"
  end

  test "should create game user" do
    visit game_users_url
    click_on "New game user"

    fill_in "Game", with: @game_user.game_id
    fill_in "Name", with: @game_user.name
    click_on "Create Game user"

    assert_text "Game user was successfully created"
    click_on "Back"
  end

  test "should update Game user" do
    visit game_user_url(@game_user)
    click_on "Edit this game user", match: :first

    fill_in "Game", with: @game_user.game_id
    fill_in "Name", with: @game_user.name
    click_on "Update Game user"

    assert_text "Game user was successfully updated"
    click_on "Back"
  end

  test "should destroy Game user" do
    visit game_user_url(@game_user)
    click_on "Destroy this game user", match: :first

    assert_text "Game user was successfully destroyed"
  end
end
