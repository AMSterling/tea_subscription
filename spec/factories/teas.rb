FactoryBot.define do
  factory :tea do
    title { Faker::Tea.type }
    description { Faker::Food.description }
    temperature { Faker::Number.within(range: 175..205) }
    brew_time { Faker::Number.within(range: 3..7) }
  end
end
