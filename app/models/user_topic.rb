class UserTopic < ApplicationRecord
  belongs_to :user
  belongs_to :topic
  has_one :subsection, through: :topic
  # belongs_to :last_read_post

  before_create do
    if self.can_post == nil
      if topic.user == self.user || topic.viewers.include?(self.user)
        self.can_post = true
      elsif topic.who_can_post == 'anyone'
        if self.user.account_level == 'guest'
          self.can_post = topic.guest_access == 'post'
        else
          self.can_post = true
        end
      end
    end
    self.status = 'unsubscribed' if !self.status
  end

  def topic_slug
    topic && topic.slug
  end

  def subsection_slug
    subsection && subsection.slug
  end

end
