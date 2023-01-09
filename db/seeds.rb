require 'faker'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

2.times do
  Customer.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.unique.free_email,
    address: Faker::Address.full_address
  )
end

5.times do
  Tea.create(
    title: Faker::Tea.type,
    description: Faker::Food.description,
    temperature: Faker::Number.within(range: 175..205),
    brew_time: Faker::Number.within(range: 3..7)
  )
end

Subscription.create(
  title: "#{Customer.first.first_name} #{Customer.first.last_name}'s #{Tea.first.title}",
  price: Faker::Number.within(range: 7..15),
  frequency: [0, 1, 2, 3].sample,
  tea_id: Tea.first.id,
  customer_id: Customer.first.id
)

Subscription.create(
  title: "#{Customer.first.first_name} #{Customer.first.last_name}'s #{Tea.second.title}",
  price: Faker::Number.within(range: 7..15),
  frequency: [0, 1, 2, 3].sample,
  tea_id: Tea.second.id,
  customer_id: Customer.first.id
)

Subscription.create(
  title: "#{Customer.first.first_name} #{Customer.first.last_name}'s #{Tea.third.title}",
  price: Faker::Number.within(range: 7..15),
  frequency: [0, 1, 2, 3].sample,
  tea_id: Tea.third.id,
  customer_id: Customer.first.id
)
