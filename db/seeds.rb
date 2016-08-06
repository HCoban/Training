# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

200.times do
  User.create(username: Faker::Internet.user_name, password: Faker::Internet.password(10, 20))
end

66.times do
  Sub.create(title: Faker::Hacker.noun,
  description: Faker::Hacker.adjective, moderator_id: User.all.sample.id)
end

rand(150).times do
  Post.create(title: Faker::Hacker.abbreviation,
  content: Faker::Hacker.say_something_smart, sub_id: rand(1..66),
  author_id: User.all.sample.id)
end
