json.errors do
  json.array! @user.errors do |e|
    json.message e.full_message
  end
end