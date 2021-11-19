class Api::V1::TopicsController < ApplicationController

  before_action :require_login, only: [:create, :update, :add_viewer, :add_poster]
  before_action :require_viewer, only: [:show]

  def create
    topic = Topic.create(topic_params)
    topic.subsection = Subsection.find_by(slug: params[:subsection_slug])
    topic.status = 'unpublished'
    topic.who_can_view = 'all'
    topic.who_can_post = 'users'
    topic.user = current_user
    topic.save
    UserTopic.create(user: current_user, topic: topic, status: 'poster')
    # post_params = params.require(:post).permit(
    #     :text
    # )
    # post_params[:user] = current_user
    # post_params[:topic] = topic
    # post = Post.new(post_params)
    # post.save
    render json: TopicSerializer.new(topic, params: {user: current_user}).serializable_hash, status: :created
  end
  
  def index
    # subsection = Subsection.find_by(slug: params[:subsection_slug])
    topics = subsection.topics.filter { |topic| topic.can_view(current_user) }
    render json: TopicSerializer.new(topics ,{params: {user: current_user}}).serializable_hash, status: :ok
  end

  def show
    render json: TopicSerializer.new(topic, {params: {user: current_user}}).serializable_hash, status: :ok
  end

  def update
    # subsection = Subsection.find_by(slug: params[:subsection_slug])
    # topic = Topic.find_by(subsection: subsection, slug: params[:topic_slug])
    if topic.user === current_user
      topic.update(topic_params)
      render_object(topic)
    else
      render json: { error: "not authorized" }, status: :not_acceptable
    end
  end

  def add_viewer
    if current_user == topic.user
      viewer = User.find_by(slug: params[:viewer_slug])
      topic.add_viewer(viewer)
    end
    render json: TopicSerializer.new(topic, {params: {user: current_user}}).serializable_hash, status: :ok
  end

  def add_poster
    if current_user == topic.user
      poster = User.find_by(slug: params[:poster_slug])
      topic.add_poster(poster)
    end
    render json: TopicSerializer.new(topic, {params: {user: current_user}}).serializable_hash, status: :ok
  end

  private

  def topic_params
    params.require(:topic).permit(
      :title,
      :who_can_view,
      :who_can_post,
    )
  end

end
