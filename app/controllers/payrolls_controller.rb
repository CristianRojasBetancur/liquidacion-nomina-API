class PayrollsController < ApplicationController
  before_action :set_payroll, only: %i[ show update destroy ]

  # GET /payrolls
  # GET /payrolls.json
  def index
    @payrolls = Payroll.all
  end

  # GET /payrolls/1
  # GET /payrolls/1.json
  def show
  end

  # POST /payrolls
  # POST /payrolls.json
  def create
    @payroll = Payroll.new(payroll_params)

    if @payroll.save
      render :show, status: :created, location: @payroll
    else
      render json: @payroll.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /payrolls/1
  # PATCH/PUT /payrolls/1.json
  def update
    if @payroll.update(payroll_params)
      render :show, status: :ok, location: @payroll
    else
      render json: @payroll.errors, status: :unprocessable_entity
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

    # Only allow a list of trusted parameters through.
    def payroll_params
      params.require(:payroll).permit(:period_id, :employeed_payment, :reten_deduc, :total_payrolls, :social_benefits, :parafiscal_cont, :social_security)
    end
end
