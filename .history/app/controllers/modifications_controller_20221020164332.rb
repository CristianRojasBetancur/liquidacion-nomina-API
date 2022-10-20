class ModificationsController < ApplicationController
  include ValidationsHelper

  before_action :authorize_request
  before_action :set_modification, only: %i[ show update destroy ]
  before_action :have_company?, :have_workers?, :at_leat_one_period_created
  before_action :valid_worker?, :valid_modification?, :can_modificate_payroll?, only: :create

  # GET /modifications
  # GET /modifications.json
  def index
    @modifications = []

    @current_user.company.periods.each do |p|
      p.modifications.each do |m|
        @modifications << m
      end
    end
  end

  # GET /modifications/1
  # GET /modifications/1.json
  def show
  end

  # POST /modifications
  # POST /modifications.json
  def create
    @modification = Modification.new(modification_params)

    if @modification.save
      render :show, status: :created
    else
      render :errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /modifications/1
  # PATCH/PUT /modifications/1.json
  def update
    if @modification.update(modification_params)
      render :show, status: :ok, location: @modification
    else
      render json: @modification.errors, status: :unprocessable_entity
    end
  end

  # DELETE /modifications/1
  # DELETE /modifications/1.json
  def destroy
    @modification.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_modification
      @modification = Modification.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def modification_params
      # params.require(:modification).permit(:period_id, :worker_id, :other_salary_incomes, :no_salary_incomes, :deductions)
      {
        period_id: @current_user.company.periods.last.id,
        worker_id: params[:modification][:worker_id],
        other_salary_incomes: params[:modification][:other_salary_incomes],
        no_salary_incomes: params[:modification][:no_salary_incomes],
        deductions: params[:modification][:deductions]
      }
    end
end
