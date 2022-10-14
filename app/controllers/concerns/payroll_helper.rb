module PayrollHelper
  extend ActiveSupport::Concern

  PERIOD_DAYS = 30
  TRANSPORT_SUBSIDY = 117172
  MINIMUM_SALARY = 1000000

  def payroll_params
    @current_user.company.workers.each do |worker|
      base_salary = worker.salary
      other_salary_income = 0 # Por ahora cero luego sera segun las modficaciones del empleado
      salary = base_salary * 30 / PERIOD_DAYS
      total_base_SS_parafiscal = salary + another_salary_income
      total_base_social_benefits = 0

      if base_salary / MINIMUM_SALARY <= 2
        total_base_social_benefits = total_base_SS_parafiscal + TRANSPORT_SUBSIDY
      else
        total_base_social_benefits = total_base_SS_parafiscal
      end
      
      no_salary_incomes = 0 # Por ahora cero luego será según las modificaciones del empleado
      total_incomes = total_base_social_benefits + no_salary_incomes

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
    withholdings_and_deductions = health + pension + solidarity_fund + subsistence_account
    withholdings_and_deductions
  end

end