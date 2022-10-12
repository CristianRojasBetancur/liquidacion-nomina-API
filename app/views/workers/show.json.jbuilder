json.data do
  json.cc @worker.cc
  json.name @worker.name
  json.company @worker.company.name
  json.salay "$#{@worker.salary}"
end
