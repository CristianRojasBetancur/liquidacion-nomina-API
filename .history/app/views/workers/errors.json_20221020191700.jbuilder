json.errors do
  json.array! @worker.errors do |e|
    json.code e.options[:code]
    json.message e.full_message
    json.object @worker.class
  end
end