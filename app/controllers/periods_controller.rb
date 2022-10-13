class PeriodsController < ApplicationController
  before_action :authorize_request

  def index
    @periods = @current_user.company.periods

    if @periods
      render :index, status: :ok
    else
      render json: {error: {
        code: "012",
        message: "Couldn't find periods for #{@current_user.company.name} company.",
        object: "Period"
      }}
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
