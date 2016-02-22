# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

# Admin
User.create!(name: "Administratör", email: "admin@mail.com",
  password: "password", password_confirmation: "password", admin: true)

example_user = User.create!(name: "Mikael Eriksson", email: "mikael@mail.com",
  password: "password", password_confirmation: "password")

example_app = example_user.user_applications.create!(name: "Mikaels app", description: "Lorem ipsum")
example_app.api_key = 'a7da72d10f387bedc973624432f3fc4a'

# Create 90 users
10.times do |n|
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
    user.user_applications.create!(name: name, description: description) unless user.admin?
  end
end

helsingborg = Location.create!(city: "Helsingborg", longitude: 12.7, latitude: 56.05)
lidingo = Location.create!(city: "Lidingö", longitude: 18.15, latitude: 59.36)

creator1 = RaceCreator.create!(name: "Pelle Eriksson", email: "pelle.e@mail.com")
creator2 = RaceCreator.create!(name: "Mikael Eriksson", email: "mikael@mail.com")

springtime = helsingborg.races.create!(name: "Springtime", date: Date.today, organiser: "IFK Helsingborg",
  web_site: "http://wwww.springtime.se", distance: 10.00, race_creator: creator1)

hbg_maraton = helsingborg.races.create!(name: "Helsingborg Maraton", date: Date.today, organiser: "IFK Helsingborg",
  web_site: "http://wwww.hbgmaraton.se", distance: 43.00, race_creator: creator1)

lidingo.races.create!(name: "Lidingöloppet", date: Date.today, organiser: "IFK Lidingö",
  web_site: "http://lidingoloppet.se/", distance: 30.00, race_creator: creator2)

springtime.tag_list = ["vårlopp", "skåne", "stad"]
hbg_maraton.tag_list = ["maraton", "skåne"]
hbg_maraton.save
springtime.save
