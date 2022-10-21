require "test_helper"

class PeriodsControllerTest < ActionDispatch::IntegrationTest
  include AuthorizationHelper

  def setup
    @token = auth_token_for_user(users(:valid_user))
    @valid_period = valid_period_params
  end

  test "should get index" do
    get periods_create_url
    assert_response :success
  end

  private

  def valid_period_params
    {
      year: 2020,
      month: 2,
      company: companies(:one)
    }
  end

  def invalid_period_params
    {
      year: 1999,
      month: 13,
      company: companies(:one)
    }
  end
end
