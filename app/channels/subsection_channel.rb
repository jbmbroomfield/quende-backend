class SubsectionChannel < ApplicationCable::Channel

    def subscribed
        stream_from "subsection_#{params[:subsection_id]}"
    end

    def self.topic_update(topic)
        subsection_id = topic.subsection.id
        ActionCable.server.broadcast(
            "subsection_#{subsection}",
            type: 'topic_update',
            topic_id: topic.id
        )
    end

end