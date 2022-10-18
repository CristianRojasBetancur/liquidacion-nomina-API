class PeriodsController < ApplicationController
  before_action :authorize_request

  def index
    begin
      @periods = @current_user.company.periods

      if @periods
        begin
          render :index, status: :ok
        rescue ActionView::Template::Error
          render json: {error: {
            code: "027",
            message: "You haven't payrolls",
            object: "Period"
          }}
        end
      else
        render json: {error: {
          code: "012",
          message: "Couldn't find periods for #{@current_user.company.name} company.",
          object: "Period"
        }}
      end
    rescue NoMethodError
      render json: {error: {
        code: "027",
        message: "You don't have a company registered",
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
