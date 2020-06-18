json.session do
  # json.user do
  #   json.partial! "v1/users/user", user: @user
  # end
  json.roles @user.roles.map(&:name)
end
