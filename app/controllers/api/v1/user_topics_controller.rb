class Api::V1::UserTopicsController < ApplicationController

    # before_action :require_login

    def show
        user_topic = UserTopic.find_or_create_by(user: current_user, topic_id: params[:topic_id])
        render_object(user_topic)
    end

end
