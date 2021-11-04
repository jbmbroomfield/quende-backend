class Post < ApplicationRecord
	
	belongs_to :user
	belongs_to :topic
	has_many :flags

	before_create do
    self.tag = self.topic.posts.count.to_s
	end

  after_commit do
		ActionCable.server.broadcast("topic_#{self.topic.id}", type: 'update')
    Notification.new_post(self.topic, self.user, self.tag)
  end

  def my_flags(user)
    self.flags.where(user: user).map { |flag| flag.category }
  end

end
