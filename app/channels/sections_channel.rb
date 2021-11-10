class SectionsChannel < ApplicationCable::Channel

  def subscribed
    stream_from 'sections'
  end

  def self.subsection_update(subsection)
    ActionCable.server.broadcast(
      'sections',
      type: 'subsection_update',
      subsection_id: subsection.id
    )
  end
  
end