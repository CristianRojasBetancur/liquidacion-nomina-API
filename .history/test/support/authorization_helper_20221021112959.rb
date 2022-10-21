module AuthorizationHelper
  def login(user)
    # The argument 'user' should be a hash that includes the params 'email' and 'password'.
    post '/login',
      params: {
        email: user[:email],
        password: 'combinacion123'
      }, as: :json
  end

  def auth_token_for_user(user)
    # The argument 'user' should be a hash that includes the params 'email' and 'password'.
    post '/login',
    params: {
      email: user[:email],
      password: 'combinacion123'
    }, as: :json
      puts "************* #{parse_response_body(response)['data']['token']} ***************"
    # The three categories below are the ones you need as authentication headers.
    response.body["data"]["token"]
  end

  private

  def parse_response_body(response)
    JSON.parse(response.body)
  end
end