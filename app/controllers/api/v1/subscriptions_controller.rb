# app/controllers/api/v1/subscriptions_controller.rb
class Api::V1::SubscriptionsController < ApplicationController
  before_action :set_subscription, only: %i[update]

  def create
    subscription = Subscription.create(sub_params)
    if subscription.save
      json_response(subscription)
    else
      render json: subscription.errors.full_messages, status: 422
    end
  end

  def update
    @sub.update(sub_params)
    json_response(@sub)
  end

  private

  def set_subscription
    @sub = Subscription.find_by_id(params[:id])
  end

  def sub_params
    params.require(:subscription).permit(:title, :price, :frequency, :tea_id, :customer_id, :status)
  end
end
