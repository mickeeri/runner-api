# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

# Admin
User.create!(name: "Administratör", email: "admin@mail.com",
  password: "password", password_confirmation: "password", admin: true)

example_user = User.create!(name: "Mikael Eriksson", email: "micke_eri@hotmail.com",
  password: "password", password_confirmation: "password")

example_app = example_user.user_applications.create!(name: "Min app", description: "lorem ipsum")
example_app.update(api_key: "cf46dd8a63811111469ea022d320f51f")

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
    name = Faker::App.name
    description = Faker::Lorem.sentence(10)
    user.user_applications.create!(name: name, description: description) unless user.admin?
  end
end

helsingborg = Location.create!(city: "Helsingborg", longitude: 12.7, latitude: 56.05)
lidingo = Location.create!(city: "Lidingö", longitude: 18.15, latitude: 59.36)

springtime = helsingborg.races.create!(name: "Springtime", date: Date.today, organiser: "IFK Helsingborg",
  web_site: "http://wwww.springtime.se", distance: 10.00, resource_owner_id: 1)

hbg_maraton = helsingborg.races.create!(name: "Helsingborg Maraton", date: '2016-06-26', organiser: "IFK Helsingborg",
  web_site: "http://wwww.hbgmaraton.se", distance: 43.00, resource_owner_id: 33)

lidingo.races.create!(name: "Lidingöloppet", date: '2016-08-28', organiser: "IFK Lidingö",
  web_site: "http://lidingoloppet.se/", distance: 30.00, resource_owner_id: 45)

#springtime.tag_list = ["vårlopp", "skåne", "stad"]
hbg_maraton.tag_list = ["maraton", "skåne"]
springtime.update(tag_list: ["vårlopp", "skåne", "stad", "milen"])
hbg_maraton.save
# springtime.save

ResourceOwner.create!(screenname: "ro", email: "resourceowner@example.com", password: "password", password_confirmation: "password")
