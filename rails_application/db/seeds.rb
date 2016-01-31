# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Developer.create(name: "Administratör", email: "admin@mail.com",
  password: "password", password_confirmation: "password", admin: true)

150.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@mailadress.se"
  password = "password"
  Developer.create!(name: name, email: email, password: password, password_confirmation: password)
end
