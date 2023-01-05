require 'rails_helper'

RSpec.describe 'Tea Subscription Request' do
  let!(:customers) { create_list(:customer, 2) }
  let!(:customer_1) { customers.first }
  let!(:customer_2) { customers.second }
  let!(:customer_1_subs) { create_list(:subscription, 3, customer: customer_1) }
  let!(:c1_sub_1) { customer_1_subs.first }
  let!(:c1_sub_2) { customer_1_subs.second }
  let!(:c1_sub_3) { customer_1_subs.third }
  let!(:customer_2_subs) { create_list(:subscription, 3, customer: customer_2) }
  let!(:c2_sub_1) { customer_2_subs.first }
  let!(:c2_sub_2) { customer_2_subs.second }
  let!(:c2_sub_3) { customer_2_subs.third }

  context 'subscrition creation' do
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

      post '/api/v1/subscriptions', headers: headers, params: JSON.generate(subscription: sub_params)
      created_sub = Subscription.last

      expect(response).to be_successful
      expect(Subscription.count).to eq(7)
      expect(created_sub.title).to eq(sub_params[:title])
      expect(created_sub.price).to eq(sub_params[:price])
      expect(created_sub.frequency).to eq('monthly')
      expect(created_sub.tea_id).to eq(sub_params[:tea_id])
      expect(created_sub.customer_id).to eq(sub_params[:customer_id])
      expect(created_sub.status).to eq('active')
    end

    it 'returns 404 if subscription cannot be created' do
      sub_params = ({
        title: '',
        price: Faker::Number.within(range: 7..15),
        frequency: 2,
        tea_id: tea.id,
        customer_id: customer.id
        })

      headers = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v1/subscriptions', headers: headers, params: JSON.generate(subscription: sub_params)

      expect(response).to have_http_status(404)
    end
  end

  context 'subscrition cancellation' do
    it 'cancels a customer subscription' do
      id = create(:subscription, status: 0).id
      previous_status = Subscription.last.status
      sub_params = { status: 1 }

      headers = { 'CONTENT_TYPE' => 'application/json' }

      patch "/api/v1/subscriptions/#{id}", headers: headers, params: JSON.generate(subscription: sub_params)
      subscription = Subscription.find_by(id: id)

      expect(response).to be_successful
      expect(subscription.status).to_not eq(previous_status)
      expect(subscription.status).to eq('cancelled')
    end

    it 'returns error if subscription cannot be cancelled' do
      id = create(:subscription, status: 0).id
      sub_params = { status: 2 }

      headers = { 'CONTENT_TYPE' => 'application/json' }

      patch "/api/v1/subscriptions/#{id}", headers: headers, params: JSON.generate(subscription: sub_params)
      subscription = Subscription.find_by(id: id)

      expect(response).to_not be_successful
      expect(response).to have_http_status(422)
      expect(response.body).to include("{\"error\":\"error\"}")
    end
  end

  context 'customer subscriptions' do
    it 'retrieves all subscriptions belonging to a customer' do
      get "/api/v1/customers/#{customer_1.id}/subscriptions"

      response_body = JSON.parse(response.body, symbolize_names: true)
      customer_subs = response_body[:data]

      expect(response).to be_successful
      customer_subs.each do |subscription|
        expect(subscription).to have_key(:id)
        expect(subscription[:id]).to be_a String
        expect(subscription).to have_key(:type)
        expect(subscription[:type]).to be_a String
        expect(subscription[:type]).to eq('subscription')
        expect(subscription).to have_key(:attributes)
        expect(subscription[:attributes]).to be_a Hash
        expect(subscription[:attributes][:title]).to be_a String
        expect(subscription[:attributes][:status]).to be_a String
        expect(subscription[:attributes][:status]).to be_in(['active', 'cancelled'])
        expect(subscription[:attributes][:price]).to be_an Integer
        expect(subscription[:attributes][:frequency]).to be_a String
        expect(subscription[:attributes][:frequency]).to be_in(['one_time', 'weekly', 'monthly', 'quarterly'])
        expect(subscription[:attributes][:tea_id]).to be_an Integer
        expect(subscription[:attributes][:customer_id]).to be_an Integer
        expect(subscription[:attributes][:customer_id]).to eq(customer_1.id)
        expect(subscription[:attributes]).to_not have_key(:created_at)
      end
    end

    it 'returns 404 if customer cannot be found' do
      id = 90_654_501

      get "/api/v1/customers/#{id}/subscriptions"

      expect(response).to have_http_status(404)
      expect { Subscription.find(id) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
