class TopicChannel < ApplicationCable::Channel

    def subscribed
        stream_from "topic_#{params[:topic_id]}"
    end

    def unsubscribed
    end

    def self.broadcast_update(topic_id)
        ActionCable.server.broadcast("topic_#{topic_id}", type: 'update')
    end

    def self.post_update(post)
        topic_id = post.topic.id
        ActionCable.server.broadcast(
            "topic_#{topic_id}",
            type: 'post_update',
            post_id: post.id,
        )
    end

end