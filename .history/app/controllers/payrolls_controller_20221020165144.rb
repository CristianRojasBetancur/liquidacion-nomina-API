class PayrollsController < ApplicationController
  include PayrollHelper
  include ValidationsHelper

  before_action :authorize_request
  before_action :have_company?, :at_leat_one_period_created, :cant_settle_payroll_in_same_period, only: :create
  before_action :set_payroll, only: %i[ show update destroy ]
  before_action :have_company?, only: :index

  # GET /payrolls
  # GET /payrolls.json
  def index
    @payrolls = []

    @current_user.company.periods.each do |p|
      
    end
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
end
