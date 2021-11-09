class UserChannel < ApplicationCable::Channel

    def subscribed
        stream_from "user_#{params[:user_id]}"
    end

    def unsubscribed
    end

    # def self.broadcast_update(user_id)
		#   ActionCable.server.broadcast("user_#{user_id}", type: 'update')
    # end

    def self.notification_update(notification)
      user_id = notification.user.id
      ActionCable.server.broadcast(
        "user_#{user_id}",
        type: 'notification_update',
        notification_id: notification.id,
      )
    end

end