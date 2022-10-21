require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:valid_user)
  end

  test "should create user" do
    assert_difference("User.count") do
      post users_url, params: { user: { email: "user@user.com", name: @user.name, password_digest: @user.password_digest } }, as: :json
    end

    assert_response :created
  end
end
