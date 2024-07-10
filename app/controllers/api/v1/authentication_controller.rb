class Api::V1::AuthenticationController < ApplicationController
  include ActionController::Cookies

  skip_before_action :authenticate, only: [:login, :register]

  def login
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      payload = { user_id: @user.id }
      secret = Rails.application.credentials.secret_key_base
      token = create_token(payload, secret)
      cookies.signed[:token] = {
        value: token,
        expires: 1.hour.from_now,
        httponly: true,
        path: '/',
        secure: Rails.env.production?
      }
      render json: { status: 'success', user_id: @user._id }
    else
      render json: { status: 'error', message: 'Invalid credentials' }, status: :unauthorized
    end
  end

  def register
    @user = User.new(user_params)
    if @user.save
      payload = { user_id: @user.id }
      secret = Rails.application.credentials.secret_key_base
      token = create_token(payload, secret)
      render json: { user_id: @user._id }, status: :created
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end


  private
  def user_params
    params.permit(:username, :email, :password, :password_confirmation)
  end

  def create_token(payload, secret)
    JWT.encode(payload, secret, 'HS256')
  end
end
