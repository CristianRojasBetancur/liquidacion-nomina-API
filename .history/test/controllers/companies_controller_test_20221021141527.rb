require "test_helper"

class CompaniesControllerTest < ActionDispatch::IntegrationTest
  include AuthorizationHelper

  setup do
    @valid_user = users(:valid_user)
    @invalid_user = users(:invalid_user)
    @other_valid_user = users(:other_valid_user)

    login(@valid_user)

    @token = auth_token_for_user(@valid_user)
    @valid_company = {
      name: "Nominapp",
      nit: "123",
      user_id: users(:other_valid_user).id
    }
  end

  test "should get index" do
    get '/companies', headers: {
      Authorization: @token
    }, as: :json
    assert_response :success
  end

  test "should create company" do
    token = auth_token_for_user(users(:other_valid_user))

    assert_difference("Company.count") do
      post '/companies', 
      params: { company: @valid_company },
      headers: {Authorization: token}, as: :json
    end

    assert_response :created
  end

  test "shouldn't create invalid company" do
    token = auth_token_for_user(@other_valid_user)

    post '/companies',
    params: { @company },
    headers: {Authorization: token}, as: :json

    assert_response :unprocessable_entity
  end

  test "should show company" do
    get company_url(@company),
    headers: {Authorization: @token}, as: :json
    assert_response :success
  end
end
