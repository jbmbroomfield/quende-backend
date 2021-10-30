class Post < ApplicationRecord
	
	belongs_to :user
	belongs_to :topic

	before_save do
        if !self.id
            self.tag = self.topic.posts.count.to_s
        end
		ActionCable.server.broadcast("topic_#{self.topic.id}", type: 'update')
	end

end
