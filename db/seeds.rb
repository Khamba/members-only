# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(name: 'sample_user', email: 'user@example.com', password: 'foobar', password_confirmation: 'foobar')

5.times do
	User.create(name: Faker::Name.name, email: Faker::Internet.email, password: 'password', password_confirmation: 'password')
end

20.times do
	Post.create(content: Faker::Lorem.paragraph(4), user_id: rand(1..6))
end
