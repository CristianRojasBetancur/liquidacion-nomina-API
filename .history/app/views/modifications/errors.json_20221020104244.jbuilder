json.errors @modification.errors.each do |e|
  json.code e.options[:code]
  json.message e.full_message
end