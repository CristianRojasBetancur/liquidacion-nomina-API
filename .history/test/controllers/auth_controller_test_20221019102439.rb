require "test_helper"

class AuthControllerTest < ActionDispatch::IntegrationTest
  include AuthorizationHelper

  def setup
    user = {email: workers(:one).email, password: workers(:one).password_digest}
  end

  test 'sign up and log in user one' do
    user_one = { email: 'userone@test.com', password: 'password' }
    login(user_one)
    assert_response :success

    (user_one)
    assert_response :success
  end
end
