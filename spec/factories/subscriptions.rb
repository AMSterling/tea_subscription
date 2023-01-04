FactoryBot.define do
  factory :subscription do
    title { "#{customer.last_name}'s #{tea.title}" }
    status { [active, inactive].sample }
    frequency { [one_time, weekly, monthly, quarterly].sample }
    tea { create(:tea) }
    customer { create(:customer) }
  end
end
