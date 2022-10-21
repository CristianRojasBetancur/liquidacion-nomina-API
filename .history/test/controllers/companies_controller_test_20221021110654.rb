require "test_helper"

class CompaniesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @company = companies(:one)
    @valid_user = {
      email: users(:valid_user).email,
      password: users(:valid_user).password_digest
    }
    login(@valid_user)
    @token = auth_token_for_user(@valid_user)
    @invalid_user = users(:invalid_user)
  end

  test "should get index" do
    get companies_url, as: :json
    assert_response :success
  end

  test "should create company" do
    assert_difference("Company.count") do
      post companies_url, params: { company: { name: @company.name, nit: @company.nit, user_id: @company.user_id } }, as: :json
    end

    assert_response :created
  end

  test "should show company" do
    get company_url(@company), as: :json
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
