class Forum < ApplicationRecord
  include SlugUniqueHelper
  include PermissionsHelper

  after_initialize :set_slug_from_title

  validate :slug_must_be_unique

  has_many :sections
  has_many :user_forums

  after_commit :broadcast_update

  def json(user)
    uf = user_forum(user)
    {
      id: self.id,
      title: self.title,
      slug: self.slug,
      description: self.description,
      permissions: self.permissions,
      user_forum: {
        level: uf.level,
        authority: uf.authority,
      }
    }
  end

  def broadcast_update
    ForumsChannel.update(self)
  end

  def set_slug_from_title
    set_slug_from(title)
  end

  def user=(user)
    make_super_admin(user)
  end
  
  def user_slug=(user_slug)
    user = User.find_by(slug: user_slug)
    user && self.user = user
  end

  def user_forum(user)
    user_forums.find_or_create_by(user: user)
  end

  def super_admins
    user_forums.super_admins.map { |uf| uf.user}
  end

  def admins
    user_forums.admins.map { |uf| uf.user}
  end

  def super_admin?(user)
    user_forum(user).super_admin?
  end

  def admin?(user)
    user_forum(user).admin?
  end

  def make_super_admin(user)
    user_forum(user).make_super_admin
  end

  def make_admin(user)
    user_forum(user).make_admin
  end

  def remove_admin(user)
    user_forum(user).remove_admin
  end
end