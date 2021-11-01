class Post < ApplicationRecord
	
	belongs_to :user
	belongs_to :topic

	before_create do
    self.tag = self.topic.posts.count.to_s
	end

  after_commit do
		ActionCable.server.broadcast("topic_#{self.topic.id}", type: 'update')
    Notification.new_post(self.topic, self.user)
  end

end
