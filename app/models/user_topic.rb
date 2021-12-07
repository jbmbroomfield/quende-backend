class UserTopic < ApplicationRecord
  belongs_to :user
  belongs_to :topic
  has_one :subsection, through: :topic
  # belongs_to :last_read_post

  def topic_slug
    topic && topic.slug
  end

  def subsection_slug
    subsection && subsection.slug
  end

end
