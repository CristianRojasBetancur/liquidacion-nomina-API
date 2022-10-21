json.data do
  json.workers @workers do |w|
    json.name w.name
    json.cc w.cc
    json.salary w.salary
    json.laboral_risk w.risk
  end
end
