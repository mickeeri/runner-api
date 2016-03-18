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
50.times do |n|
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

helsingborg = Location.create!(city: "Helsingborg")
lidingo = Location.create!(city: "Lidingö")
lund = Location.create!(city: "Lund")
stockholm = Location.create!(city: "Stockholm")
kalmar = Location.create!(city: "Kalmar")
malmo = Location.create!(city: "Malmö")
kristianstad = Location.create!(city: "Kristianstad");

ro = ResourceOwner.create!(screenname: "ro", email: "resourceowner@example.com", password: "password", password_confirmation: "password")
other_ro = ResourceOwner.create!(screenname: "example", email: "notowner@example.com", password: "secret", password_confirmation: "secret")

springtime = ro.races.create!(name: "Springtime", date: Date.today, organiser: "IFK Helsingborg",
  web_site: "http://wwww.springtime.se", distance: 10.00, location_id: helsingborg.id)

hbg_maraton = ro.races.create!(name: "Helsingborg Maraton", date: '2016-06-26', organiser: "IFK Helsingborg",
  web_site: "http://wwww.hbgmaraton.se", distance: 43.00, location_id: helsingborg.id)

ldnloppet = ro.races.create!(name: "Lidingöloppet", date: '2016-08-28', organiser: "IFK Lidingö",
  web_site: "http://lidingoloppet.se/", distance: 30.00, location_id: lidingo.id)

lundaloppet = ro.races.create!(name: "Lundaloppet", date: "2016-05-14", organiser: "IFK Lund",
  web_site: "http://www.lundaloppet.se/", distance: 10.00, location_id: lund.id)

vr = ro.races.create!(name: "Vårruset Malmö", date: "2016-05-02", organiser: "Malmö Allmänna Idrottsförening",
    web_site: "http://www.varruset.se/", distance: 5.00, location_id: malmo.id)

sm = ro.races.create!(name: "Stockholm Marathon", date: "2016-06-04", organiser: "ASICS",
    web_site: " www.stockholmmarathon.se/start", distance: 42.20, location_id: stockholm.id)

ss = ro.races.create!(name: "Startskottet", date: "2016-06-01", organiser: "Startskottet",
    web_site: "", distance: 10.00, location_id: kristianstad.id)

bo = ro.races.create!(name: "Blodomloppet", date: "2016-06-09", organiser: "Blodomloppet",
    web_site: "", distance: 5.00, location_id: stockholm.id)

tm = ro.races.create!(name: "Tjejmilen", date: "2016-09-03", organiser: "Hässelby SK",
    web_site: "http://www.tjejmilen.se/", distance: 10.00, location_id: stockholm.id)

vm = ro.races.create!(name: "Vintermarathon", date: "2016-11-05", organiser: " Fredrikshofs Friidrottsförening",
  web_site: "www.vintermarathon.se/start", distance: 42.20, location_id: stockholm.id)

springtime.update(tag_list: ["vårlopp", "skåne", "asfalt", "10km"])
lundaloppet.update(tag_list: ["skåne", "10km"])
hbg_maraton.update(tag_list: ["maraton", "skåne"])
ldnloppet.update(tag_list: ["klassiker", "långlopp"])
ldnloppet.update(tag_list: ["skåne", "halvmil", "asfalt"])
bo.update(tag_list: ["stad", "halvmil", "asfalt", "sommar"])
sm.update(tag_list: ["maraton","klassiker"])
vr.update(tag_list: ["halvmil","skåne"])
ss.update(tag_list: ["skåne","10km"])
tm.update(tag_list: ["10km", "tjejlopp"])
vm.update(tag_list: ["maraton", "asfalt"])
