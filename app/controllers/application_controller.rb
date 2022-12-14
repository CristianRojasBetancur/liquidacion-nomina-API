class ApplicationController < ActionController::API
  include JsonWebToken

  def authorize_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    begin
      @decoded = decode(header)
      @current_user = User.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: {
        error: {code: "001",
                message: "You must be logged in",
                object: "User" }}, status: :unauthorized
    end
  end
end
