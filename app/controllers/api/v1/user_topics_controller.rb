class Api::V1::UserTopicsController < ApplicationController

    before_action :require_login

    def show
        render_object(get_user_topic)
    end

    def subscribe
        sub_or_unsub(true)
    end

    def unsubscribe
        sub_or_unsub(false)
    end

    private

    def get_user_topic
        UserTopic.find_or_create_by(user: current_user, topic_id: params[:topic_id])
    end

    def sub_or_unsub(value)
        user_topic = get_user_topic
        user_topic.subscribed = value
        user_topic.save
        render_object(user_topic)
    end

end
