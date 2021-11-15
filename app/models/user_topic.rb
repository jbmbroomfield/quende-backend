class UserTopic < ApplicationRecord
  belongs_to :user
  belongs_to :topic
  # belongs_to :last_read_post

  def topic_slug
    topic.slug
  end

end
