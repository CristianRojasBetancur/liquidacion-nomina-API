require "test_helper"

class ModificationsControllerTest < ActionDispatch::IntegrationTest
  include AuthorizationHelper

  setup do
    @token = auth_token_for_user(users(:valid_user))
    @modification = modifications(:one)
    @valid_modification = valid_modification_params
    @invalid_modification = invalid_modification_params
  end

  test "should get index" do
    get '/modifications', headers: { Authorization: @token }, as: :json
    assert_response :success
  end

  test "should create valid modification" do
    
    assert_difference("Modification.count") do
      post '/modifications',
      params: { modification: @valid_modification },
      headers: { Authorization: @token }, as: :json
      puts "********** #{response.body} ************"
    end
    
    assert_response :created
  end

  test "shouldn't create invalid modification" do
    post '/modifications',
    params: {modification: @invalid_modification},
    headers: {Authorization: @token}, as: :json

    assert_response :unprocessable_entity
  end

  test "should show modification" do
    get modification_url(@modification), headers: { Authorization: @token }, as: :json
    assert_response :success
  end

  private

  def valid_modification_params
    {
      period_id: periods(:two),
      worker_id: workers(:two).id,
      other_salary_incomes: 200000,
      no_salary_incomes: 150000,
      deductions: 100000
    }
  end

  def invalid_modification_params
    {
      period_id: periods(:one),
      worker_id: workers(:one).id,
      other_salary_incomes: 200000,
      no_salary_incomes: 150000,
      deductions: 100000
    }
  end
end
