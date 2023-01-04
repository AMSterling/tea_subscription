require 'rails_helper'

RSpec.describe 'Tea Subscription Request' do
  let!(:subscriptions) { create_list(:subscription, 3) }
  let!(:subscription_1) { subscriptions.first }
  let!(:subscription_2) { subscriptions.second }
  let!(:subscription_3) { subscriptions.third }

  describe 'subscrition creation' do
    let!(:tea) { create(:tea) }
    let!(:customer) { create(:customer) }

    it 'creates a new customer subscription' do
      sub_params = ({
        title: "#{customer.first_name} #{customer.last_name}'s #{tea.title}",
        price: Faker::Number.within(range: 7..15),
        frequency: 2,
        tea_id: tea.id,
        customer_id: customer.id
        })

      headers = { "CONTENT_TYPE" => "application/json" }

      post "/api/v1/subscriptions", headers: headers, params: JSON.generate(subscription: sub_params)
      created_sub = Subscription.last

      expect(response).to be_successful
      expect(Subscription.count).to eq(4)
      expect(created_sub.title).to eq(sub_params[:title])
      expect(created_sub.price).to eq(sub_params[:price])
      expect(created_sub.frequency).to eq('monthly')
      expect(created_sub.tea_id).to eq(sub_params[:tea_id])
      expect(created_sub.customer_id).to eq(sub_params[:customer_id])
      expect(created_sub.status).to eq('active')
    end
  end

  describe 'subscrition cancellation' do
    it 'cancels a customer subscription' do
      id = create(:subscription).id
      previous_status = Subscription.last.status
      sub_params = { status: 1 }

      headers = { 'CONTENT_TYPE' => 'application/json' }

      patch "/api/v1/subscriptions/#{id}", headers: headers, params: JSON.generate(subscription: sub_params)
      subscription = Subscription.find_by(id: id)

      expect(response).to be_successful
      expect(subscription.status).to_not eq(previous_status)
      expect(subscription.status).to eq('cancelled')
    end
  end
end
