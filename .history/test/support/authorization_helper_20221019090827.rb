module AuthorizationHelper
  def login(user)
    # The argument 'user' should be a hash that includes the params 'email' and 'password'.
    post '/auth/',
      params: { email: user[:email],
                password: user[:password],
                password_confirmation: user[:password] },
      as: :json
  end

  def auth_token_for_user(user)
    # The argument 'user' should be a hash that includes the params 'email' and 'password'.
    post '/auth/sign_in/',
      params: { email: user[:email], password: user[:password] },
      as: :json
    # The three categories below are the ones you need as authentication headers.
    response.headers.slice('client', 'access-token', 'uid')
  end
end