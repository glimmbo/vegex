class ApplicationController < ActionController::API

  rescue_from(StandardError, with: :standard_error)
  rescue_from(ActiveRecord::RecordNotFound, with: :record_not_found)
  rescue_from(ActiveRecord::RecordInvalid, with: :record_invalid)

  def not_found
    render(
        status: 404,
        json: {
            status: 404,
            errors: [{
                type: "NotFound"
            }]
        }
    )
  end


  def current_user
    if session[:user_id].present?
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end
  helper_method :current_user

  def user_signed_in?
    current_user.present?
  end
  helper_method :user_signed_in?

  def authenticate_user!
    unless current_user.present?
        render json: {status: 401}, status: 401
    end
  end

  private 
  # Error Handling
  def record_not_found(error)
    render(
        status: 404,
        json: {
            status: 404,
            errors: [{
                type: error.class.to_s,
                message: error.message
            }]
        }
    )
  end

  def standard_error(error)
    logger.error error.full_message
    render(
        status: 500,
        json: {
            status: 500,
            errors: [{
                type: error.class.to_s,
                message: error.message
            }]
        }
    )
  end

  def record_invalid(error)
    record = error.record
    errors = record.errors.map do |field, message|
        {
            type: errror.class.to_s,
            record_type: record.class.to_s,
            field: field,
            message: message
        }
    end
    
    render(
        status: 422,
        json: {
            status: 422,
            errors: errors
        }
    )
  end
end
