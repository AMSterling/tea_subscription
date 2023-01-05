class ApplicationController < ActionController::API
  include Response 
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity
  rescue_from ArgumentError, with: :unprocessable_entity

  def not_found(_e)
    render json: { error: _e.to_s }, status: :not_found
  end

  def unprocessable_entity(_e)
    render json: { error: _e.to_s }, status: :unprocessable_entity
  end
end
