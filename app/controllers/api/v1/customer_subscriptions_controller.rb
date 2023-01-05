class Api::V1::CustomerSubscriptionsController < ApplicationController
  before_action :set_customer

  def index
    subscriptions = @customer.subscriptions
    json_response(subscriptions)
  end

  private

  def set_customer
    @customer = Customer.find(params[:customer_id])
  end
end
