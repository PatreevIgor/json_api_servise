require 'faker'
require 'pry'

# rake db:drop; rake db:create; rake db:migrate; rake db:seed
# bundle exec irb -I. -r app.rb

puts 'Start deleting User Post Estimation'
User.delete_all
Post.delete_all
Estimation.delete_all
puts 'Finish deleting User Post Estimation'

puts 'Start creating 100 Users'
100.times { User.create(login: Faker::Name.first_name) }
puts 'Finish creating 100 Users'

puts 'Start creating 50 IpAddress'
ip_address_list = []

50.times { ip_address_list << Faker::Internet.ip_v4_address }
puts 'Finish creating 50 IpAddress'

puts 'Start creating 5000 Posts'
(0..4).each do |n|
  Post.create(title: Faker::Name.name, text: Faker::Name.name, user_id: rand(User.first.id..(User.first.id + 100)), ip_address: ip_address_list[n])
end

5000.times do
  Post.create(title: Faker::Name.name,
              text: Faker::Name.name,
              user_id: rand(User.first.id..(User.first.id + 100)),
              ip_address: ip_address_list[rand(5..49)])
end
puts 'Finish creating 5000 Posts'

puts 'Start creating 500 Estimate'
500.times do
  Estimation.create(value: rand(1..5), post_id: rand(Post.first.id..(Post.first.id + 100)))
end
puts 'Finish creating 1000 Estimate'
