json.data do
  json.name @current_user_company.name
  json.NIT @current_user_company.nit
  json.owner @current_user_company.user.name
  json.employees @current_user_company.workers do |e|
    json.name e.name
    json.cc e.cc
    json.salary e.salary
  end
end
