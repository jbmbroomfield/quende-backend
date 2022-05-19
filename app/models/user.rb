class User < ApplicationRecord
  include Rails.application.routes.url_helpers
  include SlugUniqueHelper

  after_initialize :set_slug_from_username

  validate :slug_must_be_unique

  has_one :authentication, dependent: :delete
  has_one :email, dependent: :delete

  has_many :user_forums

  # has_many :posts
  # has_many :notifications
  # has_many :flags
  # has_many :topics
  # has_many :user_topics, dependent: :destroy

  has_one_attached :avatar_image

  scope :members, -> { where.not(level: "guest") }
  scope :guests, -> { where(level: "guest") }

  def json(jwt=nil)
    user = {
      username: username,
      slug: slug,
      level: level,
      avatar: avatar,
    }
    if jwt
      { user: user, jwt: jwt }
    else
      user
    end
  end

  def self.json(users=nil)
    users ||= self.all
    users.map(&:json)
  end

  def set_slug_from_username
    self.set_slug_from(username)
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
    user = self.create(username: username, level: 'member')
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
      guest = self.create(username: "Guest #{guest_number}", level: 'guest')
      guest.valid? ? break : guest_number += 1
    end
    guest
  end

  def guest?
    level === 'guest'
  end

  def member?
    !guest?
  end

  def super_admin?
    level === 'super_admin'
  end

  def admin?
    super_admin? || level === 'admin'
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
    {
      'guest' => -1,
      'member' => 0,
      'admin' => 1,
      'super_admin' => 2,
    }[level]
  end

  def self.destroy_guest(user)
    if user && user.level === 'guest'
      user.destroy
    end
  end

end
