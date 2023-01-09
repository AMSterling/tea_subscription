# app/controllers/concerns/response.rb
module Response
  def json_response(object, status = :ok)
    render json: SubscriptionSerializer.new(object), status: status
  end
end
