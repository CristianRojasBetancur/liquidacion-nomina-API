require "test_helper"

class PeriodsControllerTest < ActionDispatch::IntegrationTest
  include AuthorizationHelper

  etup do
    @token = auth_token_for_user(users(:valid_user))
    @valid_period = valid_period_params
    @invalid_period = invalid_period_params
  end

  test "should get index" do
    get '/periods', headers: { Authorization: @token }, as: :json
    assert_response :success
  end

  test 'should create valid period' do
    assert_difference("Period.count") do
      post '/periods', 
        params: { period: @valid_period }, headers: {
          Authorization: @token
        }, as: :json
        assert_response :created
    end
  end

  test "shouldn't create invalid period" do
    post '/periods',
    params: { period: @invalid_period },
    headers: { Authorization: @token }, as: :json

    assert_response :unprocessable_entity
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
