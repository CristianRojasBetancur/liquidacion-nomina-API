json.data do
  json.company @current_user.company.name
  json.workers @workers do |w|
    json.name w.name
    json.cc w.cc
    json.salary "$#{w.salary}"
  end
end
