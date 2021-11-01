class Notification < ApplicationRecord
  
  belongs_to :user

  after_commit do
		ActionCable.server.broadcast("notifications_user_#{self.user.id}", type: 'update')
  end

  def self.new_post(topic, user, tag)
    topic.subscribers(user).each do |subscriber|
      notification = Notification.find_or_create_by(
        user: subscriber,
        category: 'replies',
        object_id: topic.id
      ) do |notification|
        notification.number = 0
        notification.tag = tag
      end
      notification.number += 1
      notification.save
    end
  end

end
