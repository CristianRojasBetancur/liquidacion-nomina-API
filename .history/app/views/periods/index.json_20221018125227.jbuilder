json.data do
  json.periods @periods.each do |p|
    json.set! "#{Time.new(p.year, p.month).day}-#{Date.civil(p.year, p.month, -1).day}/#{Time.new(p.year, p.month).strftime("%B")}/#{Time.new(p.year).strftime("%Y")}" do
      json.company p.company.name
      if @periods.nil?
        json.payroll nil
      else
        json.payroll do
          json.total_payrolls p.payrolls.last.total_payrolls 
          json.social_security p.payrolls.last.social_benefits
          json.company_total_cost p.payrolls.last.total_company_cost
        end
      end
    end
  end
end