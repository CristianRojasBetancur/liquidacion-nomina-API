module AuthorizationHelper
  def sing_up(user)
    # The argument 'user' should be a hash that includes the params 'email' and 'password'.
    post '/users',
      params: { email: user[:email],
                password: user[:password] },
      as: :json
  end

  def auth_token_for_user(user)
    # The argument 'user' should be a hash that includes the params 'email' and 'password'.
    post '/login',
      params: { email: user[:email], password: user[:password] },
      as: :json
    # The three categories below are the ones you need as authentication headers.
    response.headers.slice('client', 'access-token', 'uid')
  end
end