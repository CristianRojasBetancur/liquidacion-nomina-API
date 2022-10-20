class PeriodsController < ApplicationController
  include ValidationsHelper

  before_action :authorize_request
  before_action :have_company?, :same_year_and_month, :settled_payroll?, only: :create
  before_action :have_company?, only: :index

  def index
    @periods = @current_user.company.periods

    puts "******************* #{@periods == []} **********************"

    if @periods != []
      render :index, status: :ok
    else
      render json: {error: {
        code: "012",
        message: "Couldn't find periods for #{@current_user.company.name} company.",
        object: "Period"
      }}, status: 404
    end
  end

  def create
    @period = Period.new(period_params)

    if @period.save
      render :show, status: :created
    else
      render :errors, status: :unprocessable_entity
    end
  end

  private

  def period_params
    {
      year: params[:period][:year],
      month: params[:period][:month],
      company_id: @current_user.company.id
    }
  end
end
