class UsersController < ApplicationController
  before_action :authorize_request, except: [:create]
  before_action :set_user, only: %i[ show destroy ]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  def show
    # validar que sea el mismo usuario que se manda por params que el current user
    render :show, status: :created, location: @current_user.id
  end

  # POST /users
  # POST /users.json
  def create
    begin
      @user = User.new(user_params)

      if @user&.save
        render :show, status: :created
      else
        render :errors, status: :unprocessable_entity
      end
    rescue ActionDispatch::Http::Parameters::ParseError
      render json: {error: {
        code: "024",
        message: "Bad request",
        object: "BodyRequest"
      }}, status: 400
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :email, :password)
    end
end
