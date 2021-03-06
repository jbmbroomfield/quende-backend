class Post < ApplicationRecord
	
	belongs_to :user, optional: true
	belongs_to :topic
	has_many :flags

	before_create do
    self.tag = self.topic.posts.count.to_s
	end

  after_commit do
    TopicChannel.post_update(self)
    SubsectionChannel.topic_update(self.topic)
    SectionsChannel.subsection_update(self.topic.subsection)
    Notification.new_post(self.topic, self.user, self.tag)
    topic.publish
  end

  def topic_slug
    topic ? topic.slug : nil
  end

  def my_flags(user)
    self.flags.where(user: user).map { |flag| flag.category }
  end

  def public_flags
    public_flags = {}
    ['like', 'dislike']. each do |category|
      public_flags[category] = self.flags.where(category: category).map do |flag|
        flag.user.username
      end
    end
    public_flags
  end

  def created_at_s(user)
    Time.zone = user ? user.time_zone : 'UTC'
    # Time.zone = 'Pacific/Honolulu'
    created_at && created_at.in_time_zone.to_s(:std)
  end

end
