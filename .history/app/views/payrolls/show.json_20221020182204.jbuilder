json.data do
  json.payroll do
    json.period "#{Time.new(@payroll.period.year, @payroll.period.month).day}-#{Date.civil(@payroll.period.year, @payroll.period.month, -1).day}/#{Time.new(@payroll.period.year, @payroll.period.month).strftime("%B")}/#{Time.new(@payroll.period.year).strftime("%Y")}"
    json.total_payrolls @payroll.period.payrolls.last.total_payrolls
    json.social_benefits @payroll.period.payrolls.last.social_benefits
  end
end
