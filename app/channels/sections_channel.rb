class SectionsChannel < ApplicationCable::Channel

  def subscribed
    stream_from 'sections'
  end

  def self.broadcast(**params)
    ActionCable.server.broadcast('sections', **params)
  end

  def self.subsection_update(subsection)
    self.broadcast(
      type: 'subsection_update',
      subsection_slug: subsection.slug
    )
  end
  
end