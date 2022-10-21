require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @token = auth_token_for_user(users(:valid_user))
    @user = users(:valid_user)
  end

  test "should get index" do
    get users_url, headers: {Authorization: @token}, as: :json
    assert_response :success
  end

  test "should create user" do
    assert_difference("User.count") do
      post users_url, params: { user: { email: "user@user.com", name: @user.name, password_digest: @user.password_digest } }, as: :json
    end

    assert_response :created
  end
end
