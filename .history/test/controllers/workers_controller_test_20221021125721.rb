require "test_helper"

class WorkersControllerTest < ActionDispatch::IntegrationTest
  include AuthorizationHelper

  setup do
    @token = auth_token_for_user(users(:valid_user))
    @valid_worker = {
      name: "Tomas",
      cc: 12345,
      salary: 1000000,
      company: companies(:one),
      risk: 3,
      transport_subsidy: "yes",
    }

  end

  test "should get index" do
    get '/workers', headers: {
      Authorization: @token
    }, as: :json
    assert_response :success
  end

  test "should create valid worker" do
    assert_difference("Worker.count") do
      post '/workers', params: { worker: @valid_worker }, headers: { Authorization: @token }, as: :json
    end

    assert_response :created
  end

  test "shouldn't create invalid worker" do
    post '/workers',
      params: { worker: workers(:one) },
      headers: { Authorization: @token }, as: :json

    assert_response :unprocessable_entity
  end

  test "should show worker" do
    get worker_url(workers(:one)), headers: { Authorization: @token }, as: :json
    assert_response :success
  end
end
