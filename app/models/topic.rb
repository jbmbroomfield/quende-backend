class Topic < ApplicationRecord

	belongs_to :subsection
	has_many :posts
  has_many :user_topics

	after_save :broadcast_update

  def subscribers
    self.user_topics.where(subscribed: true).map{ |user_topic| user_topic.user }
  end

end
