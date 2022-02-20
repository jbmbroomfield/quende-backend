class ForumsChannel < ApplicationCable::Channel

  def subscribed
    stream_from 'all_forums'
  end

  def self.broadcast(**params)
    ActionCable.server.broadcast('all_forums', **params)
  end

  def self.update
    self.broadcast(
      type: 'update'
    )
  end

end