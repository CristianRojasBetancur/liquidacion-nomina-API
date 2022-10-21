json.data do
  if @payrolls != []
    json.payrolls @current_user.company.periods.each do |period|
      period.payrolls.each do |payroll|
        json.set! "#{Time.new(payroll.period.year, payroll.period.month).day}-#{Date.civil(payroll.period.year, payroll.period.month, -1).day}/#{Time.new(payroll.period.year, payroll.period.month).strftime("%B")}/#{Time.new(payroll.period.year).strftime("%Y")}" do
          json.total_payrolls period.payrolls.last.total_payrolls
          json.social_benefits period.payrolls.last.social_benefits
          json.total_company_expenses period.payrolls.last.total_company_cost

          json.employees @current_user.company.workers.each do |worker|
            worker.payrolls.select{ |p| p.period.id == payroll.period.id }.each do |pr|
              json.name pr.worker.name
              json.employee_payment pr.employeed_payment
              json.total_deductions pr.reten_deduc
              if pr.worker.modification
                json.payroll_modification do
                  json.other_salary_incomes pr.worker.modification.other_salary_incomes
                  json.no_salary_incomes pr.worker.modification.no_salary_incomes
                  json.aditional_deductions pr.worker.modification.deductions
                end
              else
                json.payroll_modification nil
              end
            end
          end
        end
      end
    end
  else
    json.payrolls []
  end
end
