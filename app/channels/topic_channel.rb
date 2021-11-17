class TopicChannel < ApplicationCable::Channel

  def subscribed
    stream_from "topic_#{params[:topic_slug]}"
  end

  def self.broadcast(topic, **params)
    ActionCable.server.broadcast("topic_#{topic.slug}", **params)
  end

  def self.post_update(post)
    self.broadcast(
      post.topic,
      type: 'post_update',
      post_id: post.id,
    )
  end

  def self.topic_update(topic)
    self.broadcast(
      topic,
      type: 'topic_update',
    )
  end

end