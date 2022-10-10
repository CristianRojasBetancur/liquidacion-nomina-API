class UsersController < ApplicationController
  before_action :authorize_request, except: [:create]
  before_action :set_user, only: %i[ show destroy ]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  def show
    render :show, status: :created, location: @current_user.id
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    if @user.save
      render :show, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
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
