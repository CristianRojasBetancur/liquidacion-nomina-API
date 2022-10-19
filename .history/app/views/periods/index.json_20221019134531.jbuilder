json.data do
  json.periods @periods.each do |p|
    json.set! "#{Time.new(p.year, p.month).day}-#{Date.civil(p.year, p.month, -1).day}/#{Time.new(p.year, p.month).strftime("%B")}/#{Time.new(p.year).strftime("%Y")}" do
      json.company p.company.name
      if p.payrolls != []
        json.total_payrolls p.payrolls.last.total_payrolls
        json.benefits_and_social_security p.payrolls.last.total_social_benefits
        json.total_company_cost p.payrolls.last.total_company_cost
      else
        json.payrolls nil
      end
    end
  end
end