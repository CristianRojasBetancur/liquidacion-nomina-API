json.data do
  json.modification do
    json.worker_id @modification.worker_id
    json.period "#{Time.new(p.year, p.month).day}-#{Date.civil(p.year, p.month, -1).day}/#{Time.new(p.year, p.month).strftime("%B")}/#{Time.new(p.year).strftime("%Y")}"
  end
end
