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

  test "should show modification" do
    get modification_url(@modification), as: :json
    assert_response :success
  end

  test "should update modification" do
    patch modification_url(@modification), params: { modification: { deductions: @modification.deductions, no_salary_incomes: @modification.no_salary_incomes, other_salary_incomes: @modification.other_salary_incomes, period_id: @modification.period_id, worker_id: @modification.worker_id } }, as: :json
    assert_response :success
  end

  test "should destroy modification" do
    assert_difference("Modification.count", -1) do
      delete modification_url(@modification), as: :json
    end

    assert_response :no_content
  end

  private

  def valid_modification_params
    {
      period_id: periods.last.id,
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
