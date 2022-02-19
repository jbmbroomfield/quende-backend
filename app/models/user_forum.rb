class UserForum < ApplicationRecord

  belongs_to :user
  belongs_to :forum

  scope :super_admins, -> { where(admin: 'super') }
  scope :admins, -> { where(admin: ['super', 'admin']) }


  def super_admin?
    admin === 'super'
  end

  def admin?
    super_admin? || admin === 'admin'
  end

  def make_super_admin
    update(admin: 'super')
  end

  def make_admin
    update(admin: 'admin')
  end

  def remove_admin
    update(admin: nil)
  end

end
