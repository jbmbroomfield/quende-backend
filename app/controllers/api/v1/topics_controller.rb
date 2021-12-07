class Api::V1::TopicsController < ApplicationController

  before_action :require_login, only: [:create, :update, :add_viewer]
  before_action :require_viewer, only: [:show]

  def create
    topic = Topic.create(topic_params)
    topic.subsection = Subsection.find_by(slug: params[:subsection_slug])
    topic.status = 'unpublished'
    topic.who_can_view = 'anyone'
    topic.who_can_post = 'anyone'
    topic.guest_access = 'view'
    topic.user = current_user
    topic.save
    UserTopic.create(user: current_user, topic: topic, status: 'poster')
    render json: TopicSerializer.new(topic, params: {user: current_user}).serializable_hash, status: :created
  end
  
  def index
    topics = subsection.topics.filter do |topic|
      topic.can_view(current_user)
    end
    render json: TopicSerializer.new(topics ,{params: {user: current_user}}).serializable_hash, status: :ok
  end

  def show
    render json: TopicSerializer.new(topic, {params: {user: current_user}}).serializable_hash, status: :ok
  end

  def update
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
    Notification.user_added_to_topic(topic, viewer, 'viewer')
    render json: TopicSerializer.new(topic, {params: {user: current_user}}).serializable_hash, status: :ok
  end

  def add_poster
    if current_user == topic.user
      poster = User.find_by(slug: params[:poster_slug])
      Notification.user_added_to_topic(topic, poster, 'poster')
    else
      if (
        (topic.who_can_post != 'password') ||
        (topic.guest_access != 'post' && current_user.account_level == 'guest') ||
        (!topic.password || !params[:password] || topic.password != params[:password])
      )
        render json: { message: 'Unauthorized' }, status: :unauthorized
        return
      end
      poster = current_user
    end 
    topic.add_poster(poster)
    render json: TopicSerializer.new(topic, {params: {user: current_user}}).serializable_hash, status: :ok
  end

  private

  def topic_params
    params.require(:topic).permit(
      :title,
      :who_can_view,
      :who_can_post,
      :guest_access,
    )
  end

end
