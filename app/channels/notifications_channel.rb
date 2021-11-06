class NotificationsChannel < ApplicationCable::Channel

    def subscribed
        stream_from "notifications_user_#{params[:user_id]}"
    end

    def unsubscribed
    end

    def self.broadcast_update(user_id)
		ActionCable.server.broadcast("notifications_user_#{user_id}", type: 'update')
    end

end