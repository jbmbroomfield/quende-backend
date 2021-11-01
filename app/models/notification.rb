class Notification < ApplicationRecord
  
  belongs_to :user

  after_commit do
		ActionCable.server.broadcast("notifications_user_#{self.user.id}", type: 'update')
  end

  def self.new_post(topic, user)
    topic.subscribers(user).each do |subscriber|
      notification = Notification.find_or_create_by(
        user: subscriber,
        category: 'replies',
        object_id: topic.id
      )
      notification.number ||= 0
      notification.number += 1
      notification.save
    end
  end

end
