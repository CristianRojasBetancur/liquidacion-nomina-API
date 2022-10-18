json.data do
  json.year @period.year
  json.period "#{Time.new(@period.year, @period.month).day}/#{Time.new(@period.year, @period.month).strftime("%B")} - #{Date.civil(@period.year, @period.month, -1).day}/#{Time.new(@period.year, @period.month).strftime("%B")}"
  json.payroll "The payroll for this period has not yet been settled." if @period.payrolls.nil?
end