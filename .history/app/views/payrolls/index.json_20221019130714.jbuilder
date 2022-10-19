json.data do
  json.payrolls @current_user.company.periods.each do |p|
    json.set! "#{Time.new(p.year, p.month).day}-#{Date.civil(p.year, p.month, -1).day}/#{Time.new(p.year, p.month).strftime("%B")}/#{Time.new(p.year).strftime("%Y")}" do
      if @payrolls
        json.payroll do
          json.total_payrolls @payrolls.last.total_payrolls
          json.social_benefits @payrolls.last.social_benefits
          json.total_company_cost @payrolls.last.total_company_cost
        end
        json.employees @payrolls.each do |payroll|
          json.name @current_user.company.workers.find_by(id: payroll.worker_id)
          json.base_salary @current_user.company.workers.find_by(id: payroll.worker_id).salary
          json.employee_payment payroll.employeed_payment
          json.deductions payroll.reten_deduc
          json.payroll_mods nil
        end
      else
        []
      end
    end
  end
end
