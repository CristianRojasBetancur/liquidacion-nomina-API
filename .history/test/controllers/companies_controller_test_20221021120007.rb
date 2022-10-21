require "test_helper"

class CompaniesControllerTest < ActionDispatch::IntegrationTest
  include AuthorizationHelper

  setup do
    @valid_user = users(:valid_user)
    @invalid_user = users(:invalid_user)

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
        params: { company: { @valid_company } }, headers: {
          Authorization: token
        }, as: :json
        assert_response :created
    end
  end

  test "should show company" do
    get company_url(@company), headers: {
      Authorization: @token
    }, as: :json
    assert_response :success
  end

  test "should update company" do
    patch company_url(@company), params: { company: { name: @company.name, nit: @company.nit, user_id: @company.user_id } }, as: :json
    assert_response :success
  end

  test "should destroy company" do
    assert_difference("Company.count", -1) do
      delete company_url(@company), as: :json
    end

    assert_response :no_content
  end
end
