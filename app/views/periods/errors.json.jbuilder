json.errors do
  @period.errors.each do |e|
    json.code e.options[:code]
    json.message e.full_message
    json.object @period.class
  end
end