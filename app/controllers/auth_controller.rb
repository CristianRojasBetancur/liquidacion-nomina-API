class AuthController < ApplicationController
  include JsonWebToken
  before_action :authorize_request, except: :login

  def login
    @user = User.find_by_email(params[:email])
    if @user&.authenticate(params[:password])
      token = encode(user_id: @user.id)
      render json: { token: token, name: @user.name }, status: :ok
      
      # redirect_to controller: "users", action: "show", id: @user.id
    else
      render json: { error: 'Credenciales incorrectas' }, status: :unauthorized
    end
  end

  private

  def login_params
    params.permit(:email, :password)
  end
end
