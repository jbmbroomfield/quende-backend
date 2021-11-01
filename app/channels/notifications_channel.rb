class NotificationsChannel < ApplicationCable::Channel

    def subscribed
        stream_from "notifications_user_#{params[:user_id]}"
    end

    def unsubscribed
    end

end