class UserForumsChannel < ApplicationCable::Channel

    def subscribed
        stream_from "user_forums_#{params[:user_slug]}"
    end

    def self.broadcast(user, **params)
      ActionCable.server.broadcast("user_forums_#{user.slug}", **params)
    end
    
    def self.update(user_forum)
      self.broadcast(
        user_forum.user,
        type: 'update',
        forum_slug: user_forum.forum_slug,
      )
    end

end