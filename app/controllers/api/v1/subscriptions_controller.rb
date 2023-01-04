class Api::V1::SubscriptionsController < ApplicationController
  def create
    subscrition = Subscription.new(sub_params)
    if subscrition.save
      render json: SubscriptionSerializer.new(subscrition), status: :created
    else
      render status: :not_found
    end
  end

  def sub_params
    params.require(:subscription).permit(:title, :price, :frequency, :tea_id, :customer_id, :status)
  end
end
