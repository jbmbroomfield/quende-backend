class UserChannel < ApplicationCable::Channel

    def subscribed
        stream_from "user_#{params[:user_slug]}"
    end

    def self.broadcast(user, **params)
      ActionCable.server.broadcast("user_#{user.slug}", **params)
    end

    def self.notification_update(notification)
      self.broadcast(
        notification.user,
        type: 'notification_update',
        notification_id: notification.id,
      )
    end

    def self.user_update(user)
      self.broadcast(
        user,
        type: 'user_update',
      )
    end

end