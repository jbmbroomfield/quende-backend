class UserTopic < ApplicationRecord
  belongs_to :user
  belongs_to :topic
  has_one :subsection, through: :topic
  # belongs_to :last_read_post

  before_create do
    self.can_post = topic.who_can_post == 'anyone' || topic.user == self.user || topic.viewers.include?(self.user)
    self.status = 'unsubscribed' if !self.status
  end

  def topic_slug
    topic && topic.slug
  end

  def subsection_slug
    subsection && subsection.slug
  end

end
