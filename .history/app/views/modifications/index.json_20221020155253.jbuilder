json.data do
  json.modifications @modifications.each do |m|
    json.period "#{Time.new(m.period.year, m.period.month).day}-#{Date.civil(m.period.year, m.period.month, -1).day}/#{Time.new(m.period.year, m.period.month).strftime("%B")}/#{Time.new(m.period.year).strftime("%Y")}"
    
  end
end
