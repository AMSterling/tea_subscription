# app/serializers/subscription_serializer.rb
class SubscriptionSerializer
  include JSONAPI::Serializer
  attributes :title, :status, :price, :frequency, :tea_id, :customer_id
end
