class User < ApplicationRecord
  include Rails.application.routes.url_helpers

  has_many :posts
  has_many :notifications
  has_many :flags
  has_one :password_authentication
  accepts_nested_attributes_for :password_authentication

  has_one_attached :avatar_image
	
	after_save :broadcast_main_update

  def get_avatar_image
    if self.avatar_image.attached?
        # {
        #   url: rails_blob_url(self.avatar_image)
        # }
        'http://localhost:3000' + rails_blob_path(self.avatar_image, only_path: true)
    end
  end

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
