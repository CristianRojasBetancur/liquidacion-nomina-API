json.data do
  json.payroll do
    json.period "#{Time.new(@payroll.period.year, @payroll.period.month).day}-#{Date.civil(@payroll.period.year, @payroll.period.month, -1).day}/#{Time.new(@payroll.period.year, @payroll.period.month).strftime("%B")}/#{Time.new(@payroll.period.year).strftime("%Y")}"
  end
end
