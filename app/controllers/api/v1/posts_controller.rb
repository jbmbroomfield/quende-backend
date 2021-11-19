class Api::V1::PostsController < ApplicationController

  before_action :require_login, only: [:create]
  before_action :require_poster, only: [:create]
  before_action :require_viewer, only: [:index, :show]

  def create
    post = Post.new(post_params)
    post.topic = topic
    post.user = current_user
    post.save
    render json: PostSerializer.new(post, params: {user: current_user}).serializable_hash, status: :created
  end
  
  def index
    posts = Post.where(topic: topic)
    params = {user: current_user}
    render json: PostSerializer.new(posts, {params: {user: current_user}}).serializable_hash, status: :ok
  end

  def show
    render_one
  end

  private

  def post_params
    params.require(:post).permit(
      :user_id,
      :text
    )
  end

end
