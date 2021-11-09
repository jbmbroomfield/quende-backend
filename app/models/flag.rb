class Flag < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_one :topic, through: :post

  def topic
    post.topic
  end

  after_commit do
    TopicChannel.post_update(post)
  end

end
