class Topic < ApplicationRecord
  include LastPostHelper

	belongs_to :subsection
	has_many :posts
  has_many :users, through: :posts
  has_many :user_topics

	# after_save :broadcast_main_update

  before_create do
    initial_slug = title.gsub(/_/, '-').parameterize
    slug = initial_slug
    number = 1
    loop do
      topics = Topic.where(subsection: self.subsection, slug: slug)
      if topics.count > 0
        number += 1
        slug = initial_slug + "-#{number}"
      else
        break
      end
    end
    self.slug = slug
  end

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

end
