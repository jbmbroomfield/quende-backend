class Api::V1::PostsController < ApplicationController

  before_action :require_login, only: [:create]

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

  def subsection
    Subsection.find_by(slug: params[:subsection_slug])
  end

  def topic
    Topic.find_by(subsection: subsection, slug: params[:topic_slug])
  end

end
