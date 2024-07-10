class ApplicationController < ActionController::API
    include ActionController::Cookies
    before_action :authenticate
  
    def authenticate
      if token = cookies.signed[:token]
        begin
          decoded_token = JWT.decode(token, secret)
          payload = decoded_token.first
          user_id = payload["user_id"]
          @current_user = User.find(user_id)
        rescue JWT::DecodeError => exception
          render json: { message: "Error: #{exception.message}" }, status: :forbidden
        end
      else
        render json: { message: "No Authorization header sent" }, status: :forbidden
      end
    end
  
    private
  
    def secret
      ENV['SECRET_KEY_BASE'] || Rails.application.credentials.secret_key_base
    end
  
    def create_token(payload)
      JWT.encode(payload, secret)
    end
end
  