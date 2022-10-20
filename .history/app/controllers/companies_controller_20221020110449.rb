class CompaniesController < ApplicationController
  include ValidationsHelper
  
  before_action :authorize_request
  before_action :validate_current_user_company, only: :create
  before_action :set_company, only: %i[ show destroy ]

  # GET /companies
  # GET /companies.json
  def index
    if @current_user.company.nil?
      render json: { error: {
        code: "003",
        message: "#{@current_user.name} don't have company registered, register an company in POST /companies",
        object: "Company"
      } }, status: 404
    else
      @company = @current_user.company
      render :index, status: :ok
    end
  end

  # GET /companies/1
  # GET /companies/1.json
  def show
    if set_company.id == @current_user.company.id
      render :show, status: :ok
    else
      render json: {error: {
        code: "004",
        message: "you can only see the companies that you own",
        object: "Company"
      }}, status: :unauthorized
    end
  end

  # POST /companies
  # POST /companies.json
  def create
    @company = Company.new(company_params)

    if @company.save
      render :show, status: :created, location: @company
    else
      render :errors, status: :unprocessable_entity
    end
  end

  # DELETE /companies/1
  # DELETE /companies/1.json
  def destroy
    @company.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company
      begin
        @company = Company.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: {error: {
          code: "006",
          message: "doesn't exist an company with id #{params[:id]}",
          object: "Company"
        }}, status: 404
      end
    end

    def set_current_user_company
      @current_user_company = Company.find_by(user_id: @current_user.id)
    end

    # Only allow a list of trusted parameters through.
    def company_params
      {
        name: params[:company][:name],
        nit: params[:company][:nit],
        user_id: @current_user.id
      }
    end
end
