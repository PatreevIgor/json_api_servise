users = [
  { login: 'login1' },
  { login: 'login2' }
]

users.each do |u|
  User.create(u)
end
