class WorkersController < ApplicationController
  before_action :authorize_request
  before_action :set_worker, only: %i[ update destroy ]

  # GET /workers
  # GET /workers.json
  def index
    @workers = @current_user.company.workers

    if @workers.nil?
      render json: {error: {
        code: "007",
        message: "Your company don't have employees yet, register employees in POST /workers",
        object: "Worker"
      }}, status: 206
    else
      render :index, status: :ok
    end
  end

  # GET /workers/1
  # GET /workers/1.json
  def show
    begin
      matched = Worker.where(id: params[:id]).where(company_id: @current_user.company.id)
      @worker = matched[0]
      render :show, status: :ok
    rescue ActionView::Template::Error
      render json: {error: {
        code: "008",
        message: "Couldn't find employeed with id #{params[:id]} for #{@current_user.company.name} company.",
        Object: "Worker"
      }}, status: 404
    end
  end

  # POST /workers
  # POST /workers.json
  def create
    @worker = Worker.new(worker_params)

    if @worker.save
      render :show, status: :created
    else
      render :errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /workers/1
  # PATCH/PUT /workers/1.json
  def update
    if @worker.update(worker_params)
      render :show, status: :ok, location: @worker
    else
      render json: @worker.errors, status: :unprocessable_entity
    end
  end

  # DELETE /workers/1
  # DELETE /workers/1.json
  def destroy
    @worker.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_worker
      @worker = Worker.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def worker_params
      {
        name: params[:worker][:name],
        cc: params[:worker][:cc],
        salary: params[:worker][:salary],
        company_id: @current_user.company.id
      }
    end
end
