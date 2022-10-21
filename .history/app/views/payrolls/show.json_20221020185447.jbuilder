json.data do
  json.payroll do
    json.period "#{Time.new(@payroll.period.year, @payroll.period.month).day}-#{Date.civil(@payroll.period.year, @payroll.period.month, -1).day}/#{Time.new(@payroll.period.year, @payroll.period.month).strftime("%B")}/#{Time.new(@payroll.period.year).strftime("%Y")}"
    json.total_payrolls @payroll.period.payrolls.last.total_payrolls
    json.social_benefits @payroll.period.payrolls.last.social_benefits
    json.total_company_expenses @payroll.period.payrolls.last.total_company_cost

    json.employees @current_user.company.workers.each do |worker|
      worker.payrolls.select{ |p| p.period.id == @payroll.period.id }.each do |pr|
        json.name pr.worker.name
        json.employee_payment pr.employeed_payment
        json.deductions pr.reten_deduc
        json.payroll_modifications pr.worker.modification
      end
    end
  end
end
