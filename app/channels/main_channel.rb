class MainChannel < ApplicationCable::Channel

    def subscribed
        stream_from 'main_channel'
    end

    def unsubscribed
    end

    def self.broadcast_update
        ActionCable.server.broadcast('main_channel', type: 'update')
    end

end