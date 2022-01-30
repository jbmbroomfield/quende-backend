class Forum < ApplicationRecord

  include SlugHelper

  has_many :sections
  has_many :user_forums

  before_create :set_slug_from_title

  def user=(user)
    user_forum = user_forums.find_or_initialize_by(user: user)
    user_forum.status = 'admin'
    user_forum.save
  end

  def admins
    user_forums.where(status: 'admin'). map { |uf| uf.user}
  end

end