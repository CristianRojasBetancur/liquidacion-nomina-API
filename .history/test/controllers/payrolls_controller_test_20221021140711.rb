require "test_helper"

class PayrollsControllerTest < ActionDispatch::IntegrationTest
  include AuthorizationHelper

  setup do
    @token = auth_token_for_user(users(:valid_user))
    @payroll = payrolls(:one)
  end

  test "should get index" do
    get '/payrolls', headers: {Authorization: @token}, as: :json
    assert_response :success
  end

  # test "should create payroll" do
  #   assert_difference("Payroll.count") do
  #     post '/payrolls', headers: {Authorization: @token}, as: :json
  #   end

  #   assert_response :created
  # end

  test "should show payroll" do
    get payroll_url(@payroll), headers: {Authorization: @token}, as: :json
    assert_response :success
  end
end
