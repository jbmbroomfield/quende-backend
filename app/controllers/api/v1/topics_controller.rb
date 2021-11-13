class Api::V1::TopicsController < ApplicationController

    def create
        topic = Topic.create(topic_params)
        topic.subsection_id = params[:subsection_id]
        topic.save
        post_params = params.require(:post).permit(
            :text
        )
        post_params[:user] = current_user
        post_params[:topic] = topic
        post = Post.new(post_params)
        post.save
        render json: TopicSerializer.new(topic, params: {user: current_user}).serializable_hash, status: :created
    end
    
    def index
        topics = Topic.where(subsection_id: params[:subsection_id])
        render json: TopicSerializer.new(topics ,{params: {user: current_user}}).serializable_hash, status: :ok
    end

    def show
        # topic = Topic.find_by(id: params[:id])
        # subsection = Subsection.
        subsection = Subsection.find_by(slug: params[:subsection_slug])
        topic = Topic.find_by(subsection: subsection, slug: params[:topic_slug])
        render json: TopicSerializer.new(topic, {params: {user: current_user}}).serializable_hash, status: :ok
    end

    private

    def topic_params
        params.require(:topic).permit(
            :title,
        )
    end

end
