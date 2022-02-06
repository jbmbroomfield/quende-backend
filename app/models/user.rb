class User < ApplicationRecord
  include Rails.application.routes.url_helpers

  after_initialize :set_slug_from_username

  validate :slug_must_be_unique

  has_one :authentication, dependent: :delete
  has_one :email, dependent: :delete

  # has_many :posts
  # has_many :notifications
  # has_many :flags
  # has_many :topics
  # has_many :user_topics, dependent: :destroy

  has_one_attached :avatar_image

  scope :members, -> { where(guest: false) }
  scope :guests, -> { where(guest: true) }

  def set_slug_from_username
    self.slug = username.gsub(/_/, '-').parameterize
  end

  def slug_must_be_unique
    if User.where(slug: slug).where.not(id: id).count > 0
      errors.add(:slug, "must be unique")
    end
  end
  
  def email_address=(email_address)
    if email
      email.address = email_address
    else
      self.email = Email.create(user: self, address: email_address)
    end
  end
  
  def password=(password)
    if authentication
      authentication.password = password
    else
      self.authentication = Authentication.create(user: self, password: password)
    end
  end
  
  def authenticate(params)
    authentication.authenticate(params)
  end
  
  # after_save do
  #   MainChannel.broadcast_update
  #   UserChannel.user_update(self)
  # end

  def get_avatar_image
    if self.avatar_image.attached?
        # {
        #   url: rails_blob_url(self.avatar_image)
        # }
        'http://localhost:3000' + rails_blob_path(self.avatar_image, only_path: true)
    end
  end

  def to_s
    username
  end

  def self.create_member(params)
    username = params[:username]
    return false if !username
    user = self.create(username: username)
    if user.valid?
      password = params[:password]
      password && user.password = password
      email_address = params[:email_address]
      email_address && user.email_address = email_address
    end
    user
  end

  def self.create_guest
    guest_number = self.guests.count + 1
    guest = nil
    loop do
      guest = self.create(username: "Guest #{guest_number}", guest: true)
      guest.valid? ? break : guest_number += 1
    end
    guest
  end

  def self.destroy_guest(user)
    if user && user.guest
      user.destroy
    end
  end

end
