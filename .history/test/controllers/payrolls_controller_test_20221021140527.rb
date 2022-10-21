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

  test "should create payroll" do
    assert_difference("Payroll.count") do
      post '/payrolls', headers: {Authorization: @token} as: :json
    end

    assert_response :created
  end

  test "should show payroll" do
    get payroll_url(@payroll), as: :json
    assert_response :success
  end

  test "should update payroll" do
    patch payroll_url(@payroll), params: { payroll: { employeed_payment: @payroll.employeed_payment, parafiscal_cont: @payroll.parafiscal_cont, period_id: @payroll.period_id, reten_deduc: @payroll.reten_deduc, social_benefits: @payroll.social_benefits, social_security: @payroll.social_security, total_payrolls: @payroll.total_payrolls } }, as: :json
    assert_response :success
  end

  test "should destroy payroll" do
    assert_difference("Payroll.count", -1) do
      delete payroll_url(@payroll), as: :json
    end

    assert_response :no_content
  end
end
