class ApplicationController < ActionController::API
    rescue_from ActiveRecord::RecordInvalid do |exception|
        render json: {message: exception.message}, status: :unprocessable_entity
    end

    rescue_from ActiveRecord::RecordNotFound do |exception|
        render json: {message: exception.message}, status: :not_found
    end
end
