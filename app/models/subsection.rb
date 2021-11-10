class Subsection < ApplicationRecord
  include LastPostHelper

  belongs_to :section
  has_many :topics
  has_many :posts, through: :topics
    
  after_save :broadcast_main_update

  def topic_count
    topics.count
  end

  def post_count
    posts.count
  end

end
