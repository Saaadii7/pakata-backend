json.session do
  json.user do
    json.partial! "v1/users/user", user: @user
  end
  json.token @auth_token
  json.roles @user.roles.map(&:name)
end
