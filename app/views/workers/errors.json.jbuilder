json.errors do
  json.array! @worker.errors do |e|
    json.message e.full_message
  end
end