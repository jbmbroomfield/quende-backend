class Topic < ApplicationRecord

	belongs_to :subsection
	has_many :posts
  has_many :users, through: :posts
  has_many :user_topics

	# after_save :broadcast_main_update

  after_commit do
    SubsectionChannel.topic_update(self)
  end

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
    posts.count - 1
  end

  def first_poster
    first_post = posts.first
    poster = first_post && first_post.user
    poster ? {
      id: poster.id,
      attributes: {
        username: poster.username,
      }
    } : ''
  end

  def last_post(user)
    post = posts.last
    post ? {
      created_at_i: post.created_at.to_i,
      created_at_s: post.created_at_s(user),
      tag: post.tag,
      user: {
        id: post.user.id,
        attributes: {
          username: post.user.username,
        },
      },
    } : ''
  end

end
