json.data do
  if @payrolls != []
    json.payrolls @payrolls.each do |payroll|
      json.set! "#{Time.new(payroll.period.year, payroll.period.month).day}-#{Date.civil(payroll.period.year, payroll.period.month, -1).day}/#{Time.new(payroll.period.year, payroll.period.month).strftime("%B")}/#{Time.new(payroll.period.year).strftime("%Y")}" do
        json.total_payrolls payroll.total_payrolls
        json.social_benefits payroll.social_benefits
        json.total_company_cost payroll.total_company_cost
      end
    end
  else
    []
  end
end
