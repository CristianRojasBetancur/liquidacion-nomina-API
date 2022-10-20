json.data do
  if @payrolls != []
    json.payrolls @payrolls.each do |payroll|
      json.period "#{Time.new(payroll.period.year, payroll.period.month).day}-#{Date.civil(payroll.period.year, payroll.period.month, -1).day}/#{Time.new(payroll.period.year, payroll.period.month).strftime("%B")}/#{Time.new(payroll.period.year).strftime("%Y")}"
      json.total_payrolls payroll.total_payrolls
      json.social_benefits payroll.social_benefits
      json.total_company_cost payroll.total_company_cost

      json.employees @current_user.company.workers.each do |worker|
        worker.payrolls.select{ |p| p.period.id == payroll.period.id }.each do |pr|
          json.name pr.worker.name
          json.employee_payment pr.employee_payment
        end
      end
    end
    json.employees @payrolls.each do |payroll|
      json.name @current_user.company.workers.find_by(id: payroll.worker_id).name
      json.base_salary @current_user.company.workers.find_by(id: payroll.worker_id).salary
      json.employee_payment payroll.employeed_payment
      json.deductions payroll.reten_deduc
      if @current_user.company.workers.find_by(id: payroll.worker_id).modification.nil?
        json.payroll_modification {}
      else
        json.payroll_modification do
          json.other_salary_incomes @current_user.company.workers.find_by(id: payroll.worker_id).modification.other_salary_incomes
          json.no_salary_incomes @current_user.company.workers.find_by(id: payroll.worker_id).modification.no_salary_incomes
          json.deductions @current_user.company.workers.find_by(id: payroll.worker_id).modification.deductions
        end
      end
    end
  else
    []
  end
end
