json.data do
  json.cc @worker.cc
  json.name @worker.name
  json.company @worker.company.name
  json.salary @worker.salary
  json.laboral_risk @worker.risk
  json.transport_subsidy true if @worker.transport_subsidy.eql?('yes')
  json.transport_subsidy false if @worker.transport_subsidy.eql?('no')
end
