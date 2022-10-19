require "test_helper"

class AuthControllerTest < ActionDispatch::IntegrationTest
  def setup
    
  end

  def test_show
    get :show
    assert_response 200
  end
end
