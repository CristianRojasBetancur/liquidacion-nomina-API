if @company
  json.data do
    json.company_name @company.name
    json.company_NIT @company.nit
    json.company_owner @company.user.name
  end
end
