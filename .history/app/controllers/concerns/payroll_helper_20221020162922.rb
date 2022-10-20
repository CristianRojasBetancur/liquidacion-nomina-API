module PayrollHelper
  extend ActiveSupport::Concern

  PERIOD_DAYS = 30
  TRANSPORT_SUBSIDY = 117172
  MINIMUM_SALARY = 1000000

  def settle_payroll
    total_payrolls = 0
    total_social_benefits = 0
    total_company_cost = 0
    if @current_user.company.workers == []
      render json: {error: {
        code: "029",
        message: "You cannot settle payroll because your company haven't workers",
        object: "Payroll"
      }}, status: 404
    else
      @current_user.company.workers.each do |worker|
        base_salary = worker.salary
        other_salary_income = worker.modification.other_salary_incomes # Por ahora cero luego sera segun las modficaciones del empleado
        salary = base_salary * 30 / PERIOD_DAYS
        total_base_SS_parafiscal = salary + other_salary_income
        total_base_social_benefits = 0

        if base_salary / MINIMUM_SALARY <= 2 && worker.transport_subsidy.eql?("si")
          total_base_social_benefits = total_base_SS_parafiscal + TRANSPORT_SUBSIDY
        else
          total_base_social_benefits = total_base_SS_parafiscal
        end
        
        no_salary_incomes = worker.modification.no_salary_incomes # Por ahora cero luego será según las modificaciones del empleado
        total_incomes = total_base_social_benefits + no_salary_incomes
        other_deductions = worker.modification.deductions
        employee_payment = total_incomes - withholdings_and_deductions(total_base_SS_parafiscal)
        company_cost = total_incomes + social_security(total_base_SS_parafiscal, worker) + parafiscal_contribution(total_base_SS_parafiscal) + social_benefits(total_base_social_benefits, total_base_SS_parafiscal)
        puts "******************** costo empresa por #{worker.name} #{company_cost} *********************"
        total_payrolls += employee_payment
        total_social_benefits += social_benefits(total_base_social_benefits, total_base_SS_parafiscal) + social_security(total_base_SS_parafiscal, worker)
        total_company_cost += company_cost
        puts "**************** total costo empresa #{total_company_cost} *******************"
        puts "**************** total seguridad social #{total_social_benefits} *******************"


        Payroll.create!({
          period_id: @current_user.company.periods.last.id,
          employeed_payment: employee_payment,
          reten_deduc: withholdings_and_deductions(total_base_SS_parafiscal),
          total_payrolls: total_payrolls,
          social_benefits: total_social_benefits,
          parafiscal_cont: parafiscal_contribution(total_base_SS_parafiscal),
          social_security: social_security(total_base_SS_parafiscal, worker),
          worker_id: worker.id,
          total_company_cost: total_company_cost
        })

        
      end
      render :show, status: :ok
    end
  end

  def withholdings_and_deductions(total_base_SS_parafiscal)
    health = total_base_SS_parafiscal*0.04
    pension = total_base_SS_parafiscal*0.04
    solidarity_fund = 0
    solidarity_fund = total_base_SS_parafiscal*0.01 if total_base_SS_parafiscal / MINIMUM_SALARY >= 4
    subsistence_account = 0

    case total_base_SS_parafiscal / MINIMUM_SALARY
    when 16..17
      subsistence_account = total_base_SS_parafiscal*0.002
    when 17..18
      subsistence_account = total_base_SS_parafiscal*0.004
    when 18..19
      subsistence_account = total_base_SS_parafiscal*0.006
    when 19..50
      subsistence_account = total_base_SS_parafiscal*0.008
    else
      subsistence_account = 0
    end

    deductions = 0
    withholdings_and_deductions = health + pension + solidarity_fund + subsistence_account + worker.deductions
    withholdings_and_deductions
  end
  
  def social_security(total_base_SS_parafiscal, worker)
    health = 0
    health = total_base_SS_parafiscal*0.085 if total_base_SS_parafiscal/MINIMUM_SALARY >= 10
    pension = total_base_SS_parafiscal*0.12
    arl = total_base_SS_parafiscal*0.00522 if worker.risk.eql?(1)
    arl = total_base_SS_parafiscal*0.01044 if worker.risk == 2
    arl = total_base_SS_parafiscal*0.02436 if worker.risk == 3
    arl = total_base_SS_parafiscal*0.0435 if worker.risk == 4
    arl = total_base_SS_parafiscal*0.0696 if worker.risk == 5

    social_security = health + pension + arl 
    social_security
  end

  def parafiscal_contribution(total_base_SS_parafiscal)
    compensation_box = total_base_SS_parafiscal*0.04
    icbf = 0
    icbf = total_base_SS_parafiscal*0.03 if total_base_SS_parafiscal/MINIMUM_SALARY >= 10
    sena = 0
    sena = total_base_SS_parafiscal*0.02 if total_base_SS_parafiscal/MINIMUM_SALARY >= 10
    parafiscal_contribution = compensation_box + icbf + sena
    parafiscal_contribution
  end

  def social_benefits(total_base_social_benefits, total_base_SS_parafiscal)
    layoffs = (total_base_social_benefits*1/12).round
    interest_on_layoffs = (layoffs*0.12).round
    cousin_of_services = (total_base_social_benefits*1/12).round
    holidays = (total_base_SS_parafiscal*1/24).round
    social_benefits = layoffs + interest_on_layoffs + cousin_of_services + holidays
    social_benefits
  end
end