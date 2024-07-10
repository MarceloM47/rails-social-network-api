class Api::V1::PostsController < ApplicationController
  before_action :set_post, only: %i[ show update destroy ]
  before_action :authorize_user, only: %i[ show update destroy ]

  # GET /posts
  def index
    page = params[:page].to_i > 0 ? params[:page].to_i : 1
    per_page = params[:per_page].to_i > 0 ? params[:per_page].to_i : 10

    total_posts = Post.count
    total_pages = (total_posts / per_page.to_f).ceil

    @posts = Post.offset((page - 1) * per_page).limit(per_page)

    render json: {
      current_page: page,
      total_pages: total_pages,
      total_posts: total_posts,
      posts: @posts.map { |post| post_with_username(post) }
    }
  end

  # GET /posts/1
  def show
    render json: post_with_username(@post)
  end

  # POST /posts
  def create
    @post = Post.new(post_params)
    @post.user_id = @current_user._id

    if @post.save
      render json: post_with_username(@post), status: :created
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1
  def update
    if @post.update(post_params)
      render json: post_with_username(@post)
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1
  def destroy
    @post.destroy!

    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    def authorize_user
      head :forbidden unless @post.user == @current_user
    end

    def post_with_username(post)
      user = User.find(post.user_id)
      post.as_json.merge(username: user.username)
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.permit(:content)
    end        
end