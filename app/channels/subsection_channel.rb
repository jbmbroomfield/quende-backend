class SubsectionChannel < ApplicationCable::Channel

    def subscribed
        stream_from "subsection_#{params[:subsection_id]}"
    end

    def self.broadcast(subsection_id, **params)
        ActionCable.server.broadcast("subsection_#{subsection_id}", **params)
    end

    def self.topic_update(topic)
        self.broadcast(
            topic.subsection.id,
            type: 'topic_update',
            topic_id: topic.id,
        )
    end

    def self.subsection_update(subsection)
        self.broadcast(
            subsection.id,
            type: 'subsection_update',
        )
    end

end