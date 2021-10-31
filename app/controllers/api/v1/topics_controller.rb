class Api::V1::TopicsController < ApplicationController

    def create
        topic = Topic.create(topic_params)
        topic.subsection_id = params[:subsection_id]
        puts params
        post_params = params.require(:post).permit(
            :text
        )
        post_params[:user] = current_user
        post_params[:topic] = topic
        post = Post.new(post_params)
        post.save
        save_and_render(topic)
    end
    
    def index
        render_all
    end

    def show
        topic = Topic.find_by(id: params[:id])
        for_json = TopicSerializer.new(topic)
        # if current_user
        #     user_topic = UserTopic.find_or_create_by(user: current_user, topic: topic)
        #     for_json["user_topic"] = UserTopicSerializer.new(user_topic)
        # end
        render json: for_json, status: :ok
    end

    private

    def topic_params
        params.require(:topic).permit(
            :title,
        )
    end

end
