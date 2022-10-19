require "test_helper"

class AuthControllerTest < ActionDispatch::IntegrationTest
  include AuthorizationHelper

  def setup
    @valid_user = users(:valid_user)
    @invalid_user = users(:invalid_user)

    user = { email: users(:one).email, password: users(:one).password_digest }
    login(user)
    @token = auth_token_for_user(user)
  end

  test 'sign up and log in user one' do
    user_one = { email: users(:one).email, password: users(:one).password_digest }
    login(user_one)
    assert_response :success

    (user_one)
    assert_response :success
  end
end
