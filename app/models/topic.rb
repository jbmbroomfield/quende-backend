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
        slug: poster.slug,
      }
    } : ''
  end

  def url
    "forum/#{subsection.slug}/#{slug}"
  end

  def can_view(user, url = nil)
    return true if user == self.user
    return false if status == 'unpublished'
    can_view_published(user, url)
  end

  def can_view_published(user, url)
    if !guest_access
      return false if !user || user.account_level == 'guest'
    end
    return true if who_can_view == 'anyone'
    return true if viewers.include?(user)
    if who_can_view == 'url' && url && url == self.url
      add_viewer(user)
      return true
    end
    false
  end

  def can_post(user, password = nil)
    return true if user == self.user
    return false if status == 'unpublished'
    can_post_published(user, password)
  end

  def can_post_published(user, password)
    if guest_access != 'post'
      return false if !user || user.account_level == 'guest'
    end
    return true if who_can_post == 'anyone'
    return true if posters.include?(user)
    if who_can_post == 'password' && self.password && self.password == password
      add_poster(user)
      return true
    end
    false
  end

  def add_viewer(user)
    return if !user
    user.set_guest_data
    user_topic = self.user_topics.find_or_create_by(user: user)
    if !['viewer', 'poster'].include?(user_topic.status)
      user_topic.status = 'viewer'
      user_topic.save
    end
  end

  def add_poster(user)
    return if !user
    user.set_guest_data
    user_topic = self.user_topics.find_or_create_by(user: user)
    if user_topic.status != 'poster'
      user_topic.status = 'poster'
      user_topic.save
    end
  end

  def viewers
    user_topics = self.user_topics.filter { |user_topic| ['viewer', 'poster'].include?(user_topic.status) }
    user_topics.map { |user_topic| user_topic.user }.uniq
  end

  def viewers_serialized
    viewers.filter { |viewer| viewer.account_level != 'guest' }.map { |viewer| user_serialized(viewer) }
  end

  def posters
    if ['users', 'all'].include?(who_can_post)
      users.uniq
    else
      user_topics = self.user_topics.filter { |user_topic| user_topic.status == 'poster' }
      user_topics.map { |user_topic| user_topic.user }.uniq
    end
  end

  def posters_serialized
    posters.filter { |poster| poster.account_level != 'guest'}.map { |poster| user_serialized(poster) }
  end

  def user_serialized(user)
    {
      id: user.id,
      type: 'user',
      attributes: {
        username: user.username,
        slug: user.slug,
        account_level: user.account_level,
      }
    }
  end

end
