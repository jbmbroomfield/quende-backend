class UserForum < ApplicationRecord

  belongs_to :user
  belongs_to :forum

  scope :super_admins, -> { where(level: 'super_admin') }
  scope :admins, -> { where(level: ['super_admin', 'admin']) }

  after_commit :broadcast_update

  def broadcast_update
    UserForumsChannel.update(self)
  end

  def user_slug
    user.slug
  end

  def forum_slug
    forum.slug
  end

  def super_admin?
    authority > 1
  end

  def admin?
    authority > 0
  end

  def make_super_admin
    update(level: 'super_admin')
  end

  def make_admin
    update(level: 'admin')
  end

  def remove_admin
    update(level: 'member')
  end

  def authority
    return user.authority if user.authority < 0
    return user.authority + 2 if user.authority > 0
    {
      'member' => 0,
      'admin' => 1,
      'super_admin' => 2,
    }[level]
  end

end
