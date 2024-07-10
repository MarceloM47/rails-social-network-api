class Api::V1::UsersController < ApplicationController
  private

  def set_user
    @user = User.find(params[:id])
  rescue Mongoid::Errors::DocumentNotFound
    render json: { error: 'User not found' }, status: :not_found
  end
end
