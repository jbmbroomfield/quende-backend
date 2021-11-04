class User < ApplicationRecord

  has_many :posts
  has_many :notifications
  has_many :flags
  has_one :password_authentication
  accepts_nested_attributes_for :password_authentication
	
	after_save :broadcast_update

  def to_s
    "#{username} - #{id}"
  end

  def password_authenticate(password)
    password_authentication && password_authentication.authenticate(password)
  end

  def admin?
    account_level == 'admin'
  end

end
