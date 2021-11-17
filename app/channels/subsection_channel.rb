class SubsectionChannel < ApplicationCable::Channel

    def subscribed
        stream_from "subsection_#{params[:subsection_slug]}"
    end

    def self.broadcast(subsection, **params)
        ActionCable.server.broadcast("subsection_#{subsection.slug}", **params)
    end

    def self.topic_update(topic)
        self.broadcast(
            topic.subsection,
            type: 'topic_update',
            topic_slug: topic.slug,
        )
    end

    def self.subsection_update(subsection)
        self.broadcast(
            subsection,
            type: 'subsection_update',
        )
    end

end