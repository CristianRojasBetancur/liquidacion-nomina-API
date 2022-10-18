class PeriodsController < ApplicationController
  before_action :authorize_request
  before_action :same_year_and_month, :settled_payroll?, only: :create

  def index
    begin
      @periods = @current_user.company.periods

      if @periods.eql?([])
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
        }}, status: 404
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

  def same_year_and_month
    year_to_value = nil
    month_to_value = nil

    @current_user.company.periods.each do |period|
      year_to_value = period.year if period.year.eql?(params[:period][:year])
      month_to_value = period.month if period.month.eql?(params[:period][:month])
    end

    # errors.add(:base, "This period already exists", code: "010") if year_to_value && month_to_value

    if year_to_value && month_to_value
      render json: {error: {
        code: "010",
        message: "This period already exists",
        object: "Period"
      }}
    end
  end

  def settled_payroll?
    payrolls_actual_period = @current_user.company.periods.last.payrolls if @current_user.company.periods.last

    # errors.add(:base, "you cannot create another period until you settle payroll for the current period", code: "013") if payrolls_actual_period == [] && Period.all.size >= 1

    if payrolls_actual_period == [] && @current_user.company.periods.size >= 1
      render json: {error: {
        code: "013",
        message: "you cannot create another period until you settle payroll for the current period",
        object: "Period"
      }}
    end
  end
end
