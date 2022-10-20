class ModificationsController < ApplicationController
  before_action :authorize_request
  before_action :set_modification, only: %i[ show update destroy ]
  before_action :have_company?, have_workers?

  # GET /modifications
  # GET /modifications.json
  def index
    @modifications = Modification.all
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
      render :show, status: :created, location: @modification
    else
      render json: @modification.errors, status: :unprocessable_entity
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
      params.require(:modification).permit(:period_id, :worker_id, :other_salary_incomes, :no_salary_incomes, :deductions)
    end

    def have_company?
      if @current_user.company.nil?
        render json: {error: {
          code: "030",
          message: "You haven't a company registered",
          object: "Period"
        }}, status: 404
      end
    end
end
