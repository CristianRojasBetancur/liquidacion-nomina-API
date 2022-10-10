json.errors do
  json.array! @company.errors do |e|
    json.message e.full_message
  end
end