json.errors do
  json.array! @user.errors do |e|
    json.code e.options[:code]
    json.message e.full_message
    json.object @user.class
  end
end