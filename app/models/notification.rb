class Notification < ApplicationRecord
  
  belongs_to :user

  after_commit do
		UserChannel.notification_update(self)
  end

  def self.new_post(topic, user, tag)
    topic.subscribers(user).each do |subscriber|
      notification = self.get_replies_notification(subscriber, topic, tag)
      notification.number += 1
      notification.save
    end
  end

  def self.user_added_to_topic(topic, user, user_type)
    slug = topic.slug
    superslug = topic.subsection.slug
    notification = self.find_or_initialize_by(user: user, slug: slug, superslug: superslug)
    if !notification.category || !notification.category.include?('added')
      notification = self.new(user: user, slug: slug, superslug: superslug)
    end
    notification.category = "topic_added_#{user_type}"
    notification.save
  end

  def self.get_replies_notification(subscriber, topic, tag)
    slug = topic.slug
    superslug = topic.subsection.slug
    self.find_or_create_by(
        user: subscriber,
        category: 'topic_replies',
        slug: slug,
        superslug: superslug,
    ) do |notification|
      notification.number = 0
      notification.tag = tag
    end
  end

end
