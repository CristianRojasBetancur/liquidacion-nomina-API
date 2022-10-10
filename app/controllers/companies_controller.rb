class CompaniesController < ApplicationController
  before_action :authorize_request
  before_action :validate_current_user_company, only: :create
  before_action :set_company, only: %i[ show destroy ]

  # GET /companies
  # GET /companies.json
  def index
    @company = Company.find_by(user_id: @current_user.id)
    if @company.nil?
      render json: { message: "#{@current_user.name} don't have company registered, register an company in POST /companies" }, status: 206
    else
      render :index, status: :ok
    end
  end

  # GET /companies/1
  # GET /companies/1.json
  def show
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
      @company = Company.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def company_params
      {
        name: params[:company][:name],
        nit: params[:company][:nit],
        user_id: @current_user.id
      }
    end

    def validate_current_user_company
      unless @current_user.company.nil?
        render json: { error: "#{@current_user.name} already has an company registered."}, status: :unprocessable_entity
      end
    end
end
