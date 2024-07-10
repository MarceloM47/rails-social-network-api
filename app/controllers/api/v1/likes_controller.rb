class Api::V1::LikesController < ApplicationController
  before_action :set_post

  # POST /posts/:post_id/like
  def create
    @like = @post.likes.new(user: @current_user)

    if @like.save
      render json: @like, status: :created
    else
      render json: @like.errors, status: :unprocessable_entity
    end
  end

  # DELETE /posts/:post_id/like
  def destroy
    @like = @post.likes.find_by(user: @current_user)
  
    if @like
      @like.destroy
      head :no_content
    else
      render json: { error: 'Like not found' }, status: :not_found
    end
  rescue Mongoid::Errors::DocumentNotFound
    render json: { error: 'Like not found' }, status: :not_found
  end
  

  # GET /posts/:post_id/like
  def likes_count
    count = @post.likes.count
    render json: { likes_count: count }
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  rescue Mongoid::Errors::DocumentNotFound
    render json: { error: 'Post not found' }, status: :not_found
  end
end
