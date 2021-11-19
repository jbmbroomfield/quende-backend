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
    self.slug = title_slug
  end

  after_commit do
    SubsectionChannel.topic_update(self)
  end

  def title_slug
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
    slug
  end

  def random_slug
    o = [('a'..'z'), ('A'..'Z'), (0..9)].map(&:to_a).flatten
    slug = (0...12).map { o[rand(o.length)] }.join
    Topic.where(slug: slug).count > 0 ? random_slug : slug
  end

  def publish
    if self.status === 'unpublished'
      self.status = 'published'
      if !['all', 'users'].include?(self.who_can_view)
        self.slug = random_slug
      else
        self.slug = title_slug
      end
      self.save
    end
  end

  def subscribers(excluding=nil)
    self.user_topics
    .where(subscribed: true)
    .where.not(user: excluding)
    .map{ |user_topic| user_topic.user }
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

  def can_view(user, url = false)
    if status === 'unpublished'
      user === self.user
    else
      can_view_published(user, url)
    end
  end

  def can_view_published(user, url)
    case who_can_view
    when 'all'
      true
    when 'users'
      !!user
    else
      if url
        if who_can_view == 'url_all' || (who_can_view == 'url' && !!user)
          self.add_viewer(user)
          return true
        end
      end
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

  def viewers_serialized
    viewers.map { |viewer| user_serialied(viewer) }
  end

  def posters
    if ['users', 'all'].include?(who_can_post)
      users.uniq
    else
      user_topics = self.user_topics.filter { |user_topic| user_topic.status == 'poster' }
      user_topics.map { |user_topic| user_topic.user }
    end
  end

  def posters_serialized
    posters.map { |poster| user_serialied(poster) }
  end

  def user_serialied(user)
    {
      id: user.id,
      type: 'user',
      attributes: {
        username: user.username,
        slug: user.slug
      }
    }
  end

end
