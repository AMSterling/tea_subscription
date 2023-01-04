FactoryBot.define do
  factory :subscription do
    title { "#{customer.first_name} #{customer.last_name}'s #{tea.title}" }
    status { 0 }
    price { Faker::Number.within(range: 7..15) }
    frequency { [0, 1, 2, 3].sample }
    tea { create(:tea) }
    customer { create(:customer) }
  end
end
