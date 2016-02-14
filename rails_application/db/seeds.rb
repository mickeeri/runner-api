# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

# Admin
User.create(name: "Administratör", email: "admin@mail.com",
  password: "password", password_confirmation: "password", admin: true)

# Create 90 users
90.times do |n|
  name = Faker::Name.name
  email = Faker::Internet.email(name)
  password = "password"
  User.create!(name: name, email: email, password: password, password_confirmation: password)
end

# Create 3 applications per user.
User.all.each do |user|
  3.times do
    name = Faker::Company.name + ' ' + Faker::App.name
    description = Faker::Lorem.sentence(10)
    begin
      random_key = SecureRandom.hex
    end while UserApplication.exists?(api_key: random_key)
    user.user_applications.create!(name: name, description: description,
      api_key: random_key) unless user.admin?
  end
end

RaceCreator.create!(name: "Pelle Eriksson", email: "pelle.e@mail.com")
#@creator2 = RaceCreator.create!(name: Faker::Name.name, email: Faker::Internet.email(name))

RaceCreator.find(1).races.create!(name: "Springtime", date: 2016-02-15, organiser: "IFK Helsingborg",
  web_site: "http://wwww.springtime.se", distance: 10.00)
