class Subsection < ApplicationRecord

  include LastPostHelper

  include SlugHelper

  belongs_to :section
  has_many :topics
  has_many :posts, through: :topics
  
  before_create :set_slug_from_title
  
  after_save :broadcast_main_update

  def topic_count
    topics.count
  end

  def post_count
    posts.count
  end

end
