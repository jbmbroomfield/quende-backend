class UserNotificationsChannel < ApplicationCable::Channel

    def subscribed
        stream_from "user_#{params[:user_id]}_notifications"
    end

    def unsubscribed
    end

end