json.data do
  json.periods @periods.each do |p|
    json.set! "#{Time.new(p.year, p.month).day}-#{Date.civil(p.year, p.month, -1).day}/#{Time.new(p.year, p.month).strftime("%B")}/#{Time.new(p.year).strftime("%Y")}" do
      json.company p.company.name
      if p.payrolls != []
        json.payrolls p.payrolls.each do |payroll|
          
        end
      else

      end
    end
  end
end