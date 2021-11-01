class Topic < ApplicationRecord

	belongs_to :subsection
	has_many :posts
  has_many :user_topics

	after_save :broadcast_update

  def subscribers(excluding=nil)
    self.user_topics
    .where(subscribed: true)
    .where.not(user: excluding)
    .map{ |user_topic| user_topic.user }
  end

end
