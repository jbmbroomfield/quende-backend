class Subsection < ApplicationRecord
  include LastPostHelper

  belongs_to :section
  has_many :topics
  has_many :posts, through: :topics
    
  after_save :broadcast_main_update

  before_create do
    initial_slug = title.gsub(/_/, '-').parameterize
    slug = initial_slug
    number = 1
    loop do
      subsections = Subsection.where(slug: slug)
      if subsections.count > 0
        number += 1
        slug = initial_slug + "-#{number}"
      else
        break
      end
    end
    self.slug = slug
  end

  def topic_count
    topics.count
  end

  def post_count
    posts.count
  end

end
