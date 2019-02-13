# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.all.destroy
Trade.all.destroy

pass = "pass"

superuser = User.create(
  name: "Mark",
  email: "markglimm@gmail.com",
  password: pass,
  password_confirmation: pass,
  location: "Kelowna",
  about: "I was a farmer, now I'm a webdev? but I still grow stuff",
  trade_completeion: "90",
  trade_slots: "3",
  status: "active"
)

15.times do
  name = Faker::Name.first_name
  email = `#{name}@example.com`
  User.create(
    name: name,
    email: email,
    password: pass,
    password_confirmation: pass,
    location: ["Kelowna", "Vancouver", "Hope", "Abbotsford", "Vernon", "Penticton", "Langley"].sample,
    about: "about content",
    trade_completeion: [50,60,75,85,90,100].sample,
    trade_slots: [1,2,3].sample,
  )
end

users = User.all

75.times do
  Trade.create(
    user_id: users.sample.id,
    produce: ["Carrot", "Lettuce", "Kale", "Radish", "Potato", "Tomatoe", "Squash", "Green", "Beet", "Apple", "Pear"].sample,
    quantity: rand(100..10000),
    offer_user_id: users.sample.id,
    offer_produce: ["Carrot", "Lettuce", "Kale", "Radish", "Potato", "Tomatoe", "Squash", "Green", "Beet", "Apple", "Pear"].sample,
    offer_quantity:
  )