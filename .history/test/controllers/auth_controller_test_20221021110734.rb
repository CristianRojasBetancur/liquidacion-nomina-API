require "test_helper"

class AuthControllerTest < ActionDispatch::IntegrationTest
  include AuthorizationHelper

  def setup
    @valid_user = users(:valid_user)
    @invalid_user = users(:invalid_user)
  end

  test 'must sign in valid user' do
    login(@valid_user)

    assert_response :success
  end

  test 'must not sign in invalid user' do
    login(@invalid_user)

    assert_response :unauthorized
  end
end
