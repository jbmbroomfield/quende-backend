class ForumsChannel < ApplicationCable::Channel

  def subscribed
    stream_from 'forums'
  end

  def self.broadcast(**params)
    ActionCable.server.broadcast('forums', **params)
  end

  def self.update(forum)
    self.broadcast(
      type: 'update',
      forum_slug: forum.slug,
    )
  end

end