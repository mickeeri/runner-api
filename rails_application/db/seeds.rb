# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

# Admin
User.create(name: "Administratör", email: "admin@mail.com",
  password: "password", password_confirmation: "password", admin: true)

# Create 150 users
150.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@mailadress.se"
  password = "password"
  User.create!(name: name, email: email, password: password, password_confirmation: password)
end

# Create 10 applications per user.
User.all.each do |user|
  10.times do |n|
    name = Faker::App.name
    description = Faker::Lorem.sentence(10)
    begin
      random_key = SecureRandom.hex
    end while UserApplication.exists?(api_key: random_key)
    user.user_applications.create!(name: name, description: description, api_key: random_key) unless user.admin?
  end
end
