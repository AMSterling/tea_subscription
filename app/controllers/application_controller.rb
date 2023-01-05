class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from ArgumentError, with: :unprocessable_entity
  def not_found
    render json: { error: 'error' }, status: :not_found
  end

  def unprocessable_entity
    render json: { error: 'error' }, status: :unprocessable_entity
  end
end
