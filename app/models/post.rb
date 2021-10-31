class Post < ApplicationRecord
	
	belongs_to :user
	belongs_to :topic

	before_save do
    if !self.id
      self.tag = self.topic.posts.count.to_s
      self.topic.subscribers.each do |subscriber|
        notification = Notification.find_or_create_by(
          user: subscriber,
          category: 'replies',
          object_id: self.topic.id
        )
        notification.number ||= 0
        notification.number += 1
        notification.save
      end
    end
		ActionCable.server.broadcast("topic_#{self.topic.id}", type: 'update')
	end

end
