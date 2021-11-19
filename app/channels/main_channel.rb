class MainChannel < ApplicationCable::Channel

    def subscribed
        stream_from 'main_channel'
    end

    def unsubscribed
    end

    def self.broadcast(**params)
        ActionCable.server.broadcast('main_channel', **params)
    end

    def self.broadcast_update
        self.broadcast(type: 'update')
    end

end