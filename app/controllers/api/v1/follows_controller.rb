class Api::V1::FollowsController < ApplicationController
    before_action :set_user, only: [:index, :follow, :unfollow]

    def index
        @follows = @user.active_follows
        @followers = @user.passive_follows
        
        result = {
          follows: @follows,
          followers: @followers
        }
    
        render json: result
    end    

    def follow
        if @current_user.following.include?(@user)
            render json: { error: 'Already following this user' }, status: :unprocessable_entity
        else
            follow = @current_user.active_follows.build(followee: @user)
            if follow.save
                render json: { success: 'Successfully followed the user' }, status: :ok
            else
                render json: { error: 'Failed to follow the user' }, status: :unprocessable_entity
            end
        end
    end

    def unfollow
    follow = @current_user.active_follows.find_by(followee: @user)
    
    if follow
        follow.destroy
        render json: { success: 'Successfully unfollowed the user' }, status: :ok
    else
        render json: { error: 'Not following this user' }, status: :unprocessable_entity
    end
    rescue Mongoid::Errors::DocumentNotFound
        render json: { error: 'Not following this user' }, status: :unprocessable_entity
    end      

    private

    def set_user
        @user = User.find(params[:id])
    end
end
