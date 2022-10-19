class PayrollsController < ApplicationController
  include PayrollHelper

  before_action :authorize_request
  before_action :at_leat_one_period_created, only: :create
  before_action :set_payroll, only: %i[ show update destroy ]

  # GET /payrolls
  # GET /payrolls.json
  def index
    @payrolls = @current_user.company.periods.last.payrolls
    p "****************** #{@payrolls.last} **********************"
    render :index, status: :ok
  end

  # GET /payrolls/1
  # GET /payrolls/1.json
  def show
  end

  # POST /payrolls
  # POST /payrolls.json
  def create
    begin
      settle_payroll
    rescue NoMethodError
      render json: {error: {
        code: "016",
        message: "You can't settle payroll without create a period",
        object: "Payroll"
      }}
    end
  end

  # DELETE /payrolls/1
  # DELETE /payrolls/1.json
  def destroy
    @payroll.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_payroll
      @payroll = Payroll.find(params[:id])
    end

    def at_leat_one_period_created
      if @current_user.company.periods.size == 0
        render json: {error: {
          code: "016",
          message: "You can't settle payroll without create a period",
          object: "Payrrol"
        }}
      end
    end

    def cant_settle_payroll_in_same_period
      if @current_user.company.periods.last.payrolls != []

      end
    end
end
