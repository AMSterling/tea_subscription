# app/controllers/application_controller.rb
class ApplicationController < ActionController::API
  include Response
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity
  rescue_from ArgumentError, with: :unprocessable_entity

  def not_found(errors)
    render json: { error: errors.message }, status: :not_found
  end

  def unprocessable_entity(errors)
    render json: { error: errors.message }, status: :unprocessable_entity
  end
end
