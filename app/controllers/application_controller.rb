class ApplicationController < ActionController::API
  before_action :authorized

  rescue_from ActionController::ParameterMissing, with: :handle_parameter_errors
  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found_errors

  def handle_parameter_errors(error)
    render json: { error: "Invalid Request" }, status: :bad_request
  end

  def handle_not_found_errors(error)
    render json: { error: "Not found with provided params" }, status: :not_found
  end
  
  
  def valid_secret?
    request.headers['Authorization'].end_with?(ENV['SECRET_KEY'])
  end

  def authorized
    render json: { error: 'Wrong key secret' }, status: :unauthorized unless valid_secret?
  end
end
