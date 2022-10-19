json.data do
  json.payrolls @current_user.company.periods.each do |p|
    json.set! "#{Time.new(p.year, p.month).day}-#{Date.civil(p.year, p.month, -1).day}/#{Time.new(p.year, p.month).strftime("%B")}/#{Time.new(p.year).strftime("%Y")}" do
      if @payrolls != []
        json.payroll do
          json.total_payrolls @payrolls.last.total_payrolls
          json.social_benefits @payrolls.last.social_benefits
          json.total_company_cost @payrolls.last.total_company_cost
          json.employees @current_user.company.workers.each do |worker|

          end
        end
      else
        []
      end
    end
  end
end
