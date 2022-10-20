module ValidationsHelper
  extend ActiveSupport::Concern

  private

  def have_company?
    if @current_user.company.nil?
      render json: {error: {
        code: "030",
        message: "You haven't a company registered",
        object: "Company"
      }}, status: 404
    end
  end

  def have_workers?
    if @current_user.company.workers == []
      render json: {error: {
        code: "029",
        message: "You don't have employees",
        object: "Worker"
      }}, status: 404
    end
  end

  def at_leat_one_period_created
    if @current_user.company.nil?  
      render json: {error: {
        code: "030",
        message: "You haven't a company registered, register a company in POST /companies",
        object: "Company"
      }}, status: 404
    else
      if @current_user.company.periods.size == 0
        render json: {error: {
          code: "016",
          message: "You don't have a period created, create a period in POST /periods",
          object: "Period"
        }}, status: 404
      end
    end
  end

  def cant_settle_payroll_in_same_period
    if @current_user.company.periods.last.payrolls != []
      render json: {error: {
        code: "031",
        message: "You already settled payroll in this period",
        object: "Payrrol"
      }}, status: :unprocessable_entity
    end
  end

  def same_year_and_month
    year_to_value = nil
    month_to_value = nil

    if @current_user.company.nil?
      render json: {error: {
        code: "030",
        message: "You haven't a company registered, register a company in POST /companies",
        object: "Period"
      }}, status: 404
    else
      @current_user.company.periods.each do |period|
        year_to_value = period.year if period.year.eql?(params[:period][:year])
        month_to_value = period.month if period.month.eql?(params[:period][:month])
      end
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

  def validate_current_user_company
    unless @current_user.company.nil?
      render json: { error: {
        code: "016",
        message: "#{@current_user.name} already has an company registered.",
        object: "Company"
      }}, status: :unprocessable_entity
    end
  end

  def valid_worker?
    matched_worker = @current_user.company.workers.find_by(id: params[:modification][:worker_id])

    if matched_worker.nil?
      render json: {error: {
        code: "035",
        message: "couldn't find employee with id #{params[:modification][:worker_id]} for #{@current_user.company.name} company",
        object: "Worker"
      }}, status: 404
    end
  end

  def valid_modification?
    matched_modification = @current_user.company.periods.last.modifications.find_by(worker_id: params[:modification][:worker_id])

    unless matched_modification.nil?
      render json: {error: {
        code: "036",
        message: "Already exists payroll modification for employee with id #{params[:modification][:worker_id]} in this period",
        object: "Modification"
      }}, status: 422
    end
  end
end