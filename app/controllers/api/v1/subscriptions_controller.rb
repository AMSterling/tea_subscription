class Api::V1::SubscriptionsController < ApplicationController
  before_action :set_subscription, only: %i[update]
  def create
    subscrition = Subscription.new(sub_params)
    if subscrition.save
      render json: SubscriptionSerializer.new(subscrition), status: :created
    else
      render status: :not_found
    end
  end

  def update
    if @sub.update(sub_params)
      render json: SubscriptionSerializer.new(@sub)
    else
      render status: :not_found
    end
  end

  private

  def set_subscription
    @sub = Subscription.find_by_id(params[:id])
  end

  def sub_params
    params.require(:subscription).permit(:title, :price, :frequency, :tea_id, :customer_id, :status)
  end
end
