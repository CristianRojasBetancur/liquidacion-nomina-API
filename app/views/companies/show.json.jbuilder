json.data do
  json.name @company.name
  json.NIT @company.nit
  json.owner @company.user.name
  json.employees @company.workers do |e|
    json.name e.name
    json.cc e.cc
    json.salary e.salary
  end
end
