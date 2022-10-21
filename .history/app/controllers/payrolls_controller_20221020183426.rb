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
      p.payrolls.each do |payroll|
        @payrolls << payroll
      end
    end
    puts "******************* #{@payrolls} ********************"
    render :index, status: :ok
  end

  # GET /payrolls/1
  # GET /payrolls/1.json
  def show
  end

  # POST /payrolls
  # POST /payrolls.json
  def create
      settle_payroll
  end

  # DELETE /payrolls/1
  # DELETE /payrolls/1.json
  def destroy
    @payroll.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_payroll
      @payroll = @current_user.company.periods.last.payrolls.find_by(id: params[:id])

      if @payroll.nil?
        render json: {error: {
          code: "037",
          message: "Couldn't find payroll with id #{params[:id]} for #{@current_user.company.name} company",
          object: "Payroll"
        }}, status: 404
      end
    end
end
