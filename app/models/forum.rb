class Forum < ApplicationRecord
  include SlugUniqueHelper

  after_initialize :set_slug_from_title

  validate :slug_must_be_unique

  has_many :sections
  has_many :user_forums

  def set_slug_from_title
    set_slug_from(title)
  end

  def user=(user)
    user_forum = user_forums.find_or_initialize_by(user: user)
    user_forum.status = 'admin'
    user_forum.save
  end

  def admins
    user_forums.where(status: 'admin'). map { |uf| uf.user}
  end

end