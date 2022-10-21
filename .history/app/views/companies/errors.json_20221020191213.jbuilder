json.errors do
  json.array! @company.errors do |e|
    json.code e.options[:code]
    json.message e.full_message
    json.object @company.class
  end
end