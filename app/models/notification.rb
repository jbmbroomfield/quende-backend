class Notification < ApplicationRecord
  
  belongs_to :user

  after_commit do
		NotificationsChannel.broadcast_update(self.user.id)
  end

  def self.new_post(topic, user, tag)
    topic.subscribers(user).each do |subscriber|
      notification = self.get_replies_notification(subscriber, topic.id, tag)
      notification.number += 1
      notification.save
    end
  end

  def self.get_replies_notification(subscriber, topic_id, tag)
    Notification.find_or_create_by(
        user: subscriber,
        category: 'replies',
        object_id: topic_id
    ) do |notification|
      notification.number = 0
      notification.tag = tag
    end
  end

end
