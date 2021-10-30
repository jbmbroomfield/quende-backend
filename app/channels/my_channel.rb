class MyChannel < ApplicationCable::Channel

    def subscribed
        puts "------------------------SUBSCRIBED!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!--------------------------"
        stream_from 'my_channel'
        MyChannel.all_posts(Post.all)
    end

    def unsubscribed
        puts "--------------------------UNSUBSCRIBED!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!-------------------------"
    end

    def self.send_text(text)

        ActionCable.server.broadcast('my_channel',
            text: 'text'
        )
    end

    def self.all_posts(posts)
        puts "---------------------------------------------------------------------ALL POSTS--------------------------------------------"
        ActionCable.server.broadcast('my_channel', history: posts)
    end

end
