json.data do
  json.modification do
    json.period "#{Time.new(@modification.period.year, @modification.period.month).day}-#{Date.civil(@modification.period.year, @modification.period.month, -1).day}/#{Time.new(@modification.period.year, @modification.period.month).strftime("%B")}/#{Time.new(@modification.period.year).strftime("%Y")}"
    json.worker_id @modification.worker_id
    json.other_salary_incomes @modification.other_salary_incomes
    json.no_salary_incomes @modification.no_salary_incomes
    json.deductions @modification.deductions
  end
end
