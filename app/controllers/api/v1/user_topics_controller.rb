class Api::V1::UserTopicsController < ApplicationController

    before_action :require_login

    def show
        render_object(get_user_topic)
    end

    def subscribe
        user_topic = get_user_topic
        user_topic.subscribed = true
        save_and_render(user_topic)
    end

    def unsubscribe
        user_topic = get_user_topic
        user_topic.subscribed = false
        save_and_render(user_topic)
    end

    private

    def get_user_topic
        UserTopic.find_or_create_by(user: current_user, topic_id: params[:topic_id])
    end

end
