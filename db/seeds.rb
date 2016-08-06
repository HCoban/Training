# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

200.times do
  User.create(username: Faker::Pokemon.name, password: 'password')
end

66.times do
  Sub.create(title: Faker::Name.title, description: Faker::Lorem.sentence(4),
             moderator_id: rand(200) + 1)
end

rand(150).times do
  Post.create(title: Faker::StarWars.character, content: Faker::StarWars.quote, sub_id: rand(1..66),
              author_id: (User.ids).sample)
end
