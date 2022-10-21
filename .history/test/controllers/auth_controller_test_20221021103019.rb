require "test_helper"

class AuthControllerTest < ActionDispatch::IntegrationTest
  include AuthorizationHelper

  def setup
    @valid_user = {
      email: users(:valid_user).email,
      password: BCrypt::Password.create('combinacion123')
    }
    @invalid_user = users(:invalid_user)
  end

  test 'sign up and log in user one' do
    login(@valid_user)

    assert_response :success
  end
end
