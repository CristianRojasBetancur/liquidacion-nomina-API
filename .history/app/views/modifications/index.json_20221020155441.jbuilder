json.data do
  json.modifications @modifications.each do |m|
    json.period "#{Time.new(m.period.year, m.period.month).day}-#{Date.civil(m.period.year, m.period.month, -1).day}/#{Time.new(m.period.year, m.period.month).strftime("%B")}/#{Time.new(m.period.year).strftime("%Y")}"
    json.employee do
      json.name m.worker.name
      json.cc m.worker.cc
    end
    json.other_salary_incomes m.other_salary_incomes
    json.no_salary_incomes m.no_salary_incomes
    json.deductions m.deductions
  end
end
