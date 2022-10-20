json.data do
  if @payrolls != []
    # json.payrolls @payrolls.each do |payroll|
    #   json.set! "#{Time.new(payroll.period.year, payroll.period.month).day}-#{Date.civil(payroll.period.year, payroll.period.month, -1).day}/#{Time.new(payroll.period.year, payroll.period.month).strftime("%B")}/#{Time.new(payroll.period.year).strftime("%Y")}" do
    #     json.total_payrolls payroll.total_payrolls
    #     json.social_benefits payroll.social_benefits
    #     json.total_company_cost payroll.total_company_cost
    #   end
    #   json.employees @current_user.company.workers.each do |worker|
    #     worker.payrolls.select{ |p| p.period.id == payroll.period.id }.each do |pr|
    #       json.name pr.worker.name
    #       json.employee_payment pr.employeed_payment
    #       json.deductions pr.reten_deduc
    #     end
    #   end
    # end
    json.payrolls @current_user.company.periods.each do |period|
      period.payrolls.each do |payroll|
        json.set! "#{Time.new(payroll.period.year, payroll.period.month).day}-#{Date.civil(payroll.period.year, payroll.period.month, -1).day}/#{Time.new(payroll.period.year, payroll.period.month).strftime("%B")}/#{Time.new(payroll.period.year).strftime("%Y")}" do
          json.total_payrolls period.payrolls.last.total_payrolls
          json.social_benefits period.payrolls.last.social_benefits
        end
      end
    end
  else
    []
  end
end
