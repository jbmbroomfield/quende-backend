class Post < ApplicationRecord
	
	belongs_to :user
	belongs_to :topic

	before_create do
    self.tag = self.topic.posts.count.to_s
	end

  after_commit do
		ActionCable.server.broadcast("topic_#{self.topic.id}", type: 'update')

    self.topic.subscribers(self.user).each do |subscriber|
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

end
