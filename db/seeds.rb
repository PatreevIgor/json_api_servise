require 'faker'
require 'pry'
require 'activerecord-import'

puts 'Start deleting User Post Estimation'
User.delete_all
Post.delete_all
Estimation.delete_all
puts 'Finish deleting User Post Estimation'

puts 'Start creating 100 Users'
users = []
n = 1
100.times do
  users << { id: n, login: Faker::Name.first_name }
  n += 1
end
User.insert_all users
puts 'Finish creating 100 Users'

puts 'Start creating 50 IpAddress'
ip_address_list = []
50.times { ip_address_list << Faker::Internet.ip_v4_address }
puts 'Finish creating 50 IpAddress'

puts 'Start creating 200 000 Posts'
(0..4).each do |n|
  Post.create(title: Faker::Name.name,
              text: Faker::Name.name,
              user_id: rand(User.first.id..(User.first.id + 100)),
              ip_address: ip_address_list[n])
end

puts 'prepare posts data'
posts = []
n = 5
200_000.times do
  posts << { id: n,
             title: Faker::Name.name,
             text: Faker::Name.name,
             user_id: rand(User.first.id..(User.first.id + 100)),
             ip_address: ip_address_list[rand(5..49)] }
  n += 1

  puts n
end
puts 'insert posts data'
Post.insert_all posts
puts 'Finish creating 200 000 Posts'

puts 'Start creating 5000 Estimate'
estimations = []
n = 1
5000.times do
  estimations << { id: n, value: rand(1..5), post_id: rand(Post.first.id..(Post.first.id + 100)) }
  n += 1
end

Estimation.insert_all estimations
puts 'Finish creating 5000 Estimate'
