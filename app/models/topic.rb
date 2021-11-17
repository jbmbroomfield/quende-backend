class Topic < ApplicationRecord
  include LastPostHelper

	belongs_to :subsection
  belongs_to :user
	has_many :posts
  has_many :users, through: :posts
  has_many :user_topics



  after_commit do
    TopicChannel.topic_update(self)
    SubsectionChannel.topic_update(self)
    SectionsChannel.subsection_update(self.subsection)
  end

  def subsection_slug
    subsection.slug
  end

  def user_slug
    user.slug
  end

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

  def can_view(user)
    if status === 'unpublished'
      user === self.user
    else
      can_view_published(user)
    end
  end

  def can_view_published(user)
    case who_can_view
    when 'all'
      true
    when 'users'
      !!user
    else
      user_topic = self.user_topics.find_by(user: user)
      user_topic && ['viewer', 'poster'].include?(user_topic.status)
    end
  end

  def can_post(user)
    if status === 'unpublished'
      user === self.user
    else
      can_post_published(user)
    end
  end

  def can_post_published(user)
    case who_can_post
    when 'all'
      can_view(user)
    when 'users'
      !!user && can_view(user)
    else
      user_topic = self.user_topics.find_by(user: user)
      user_topic && user_topic.status == 'poster'
    end
  end

  def add_viewer(user)
    user_topic = self.user_topics.find_or_create_by(user: user)
    if !['viewer', 'poster'].include?(user_topic.status)
      user_topic.status = 'viewer'
      user_topic.save
    end
  end

  def add_poster(user, password = nil)
    return if self.password && self.password != password
    user_topic = self.user_topics.find_or_create_by(user: user)
    if user_topic.status != 'poster'
      user_topic.status = 'poster'
      user_topic.save
    end
  end

  def viewers
    user_topics = self.user_topics.filter { |user_topic| ['viewer', 'poster'].include?(user_topic.status)}
    user_topics.map { |user_topic| user_topic.user }
  end

  def posters
    user_topics = self.user_topics.filter { |user_topic| user_topic.status == 'poster' }
    user_topics.map { |user_topic| user_topic.user }
  end

end
