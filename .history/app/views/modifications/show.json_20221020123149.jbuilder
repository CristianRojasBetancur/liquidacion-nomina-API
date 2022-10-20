json.data do
  json.modification do
    json.period "#{Time.new(@modification.period.year, @modification.period.month).day}-#{Date.civil(@modification.period.year, @modification.period.month, -1).day}/#{Time.new(@modification.period.year, @modification.period.month).strftime("%B")}/#{Time.new(@modification.period.year).strftime("%Y")}"
  end
end
