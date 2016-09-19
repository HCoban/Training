# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:

  # cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
  # Mayor.create(name: 'Emanuel', city: cities.first)

  
100.times { User.create!(name: Faker::Name.name) }
10.times { Poll.create!(author_id: (rand(100)+1), title: Faker::Lorem.sentence) }

poll_num = 1
while poll_num < 11
  rand(1...5).times do
    Question.create!(poll_id: poll_num, body: (Faker::Lorem.sentence[0...-1] + '?'))
  end
  poll_num += 1
end

Question.all.count.times do |i|
  5.times do
    AnswerChoice.create!(body: Faker::Beer.name, question_id: (i + 1))
  end
end

user_answer_sets = []

2000.times do
  user_id = rand(1..100)
  choice_id = rand(1..AnswerChoice.all.count)
  user_answer_sets << [user_id, choice_id]
end

user_answer_sets.uniq!
user_answer_sets.each do |set|
  Response.create(respondent_id: set.first, choice_id: set.last)
end
