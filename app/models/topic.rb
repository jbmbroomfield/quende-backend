class Topic < ApplicationRecord

	belongs_to :subsection
	has_many :posts
  has_many :users, through: :posts
  has_many :user_topics

	after_save :broadcast_main_update

  def subscribers(excluding=nil)
    self.user_topics
    .where(subscribed: true)
    .where.not(user: excluding)
    .map{ |user_topic| user_topic.user }
  end

  def posters
    users.uniq.map { |user| user.username }
  end

  def post_count
    posts.count
  end

  def last_post(user)
    post = posts.last
    post ? {
      created_at_s: post.created_at_s(user),
      tag: post.tag
    } : ''
  end

end
