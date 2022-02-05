class User < ApplicationRecord
  include Rails.application.routes.url_helpers

  after_initialize :set_slug_from_username

  validate :slug_must_be_unique

  has_one :authentication, dependent: :delete
  has_one :email, dependent: :delete

  has_many :posts
  has_many :notifications
  has_many :flags
  has_many :topics
  has_many :user_topics, dependent: :destroy

  has_one_attached :avatar_image

  scope :guests, -> { where(guest: true) }

  def create_authentication
    if !authentication
      self.authentication = Authentication.create(user: self)
    end
  end

  def authenticate(params)
    authentication.authenticate(params)
  end

  def email_address=(email_address)
    if !email
      self.email = Email.create(user: self, address: email_address)
      return
    end
    email.address = email_address
  end

  def password=(password)
    create_authentication && authentication.password = password
  end

  def set_slug_from_username
    self.slug = username.gsub(/_/, '-').parameterize
  end

  def slug_must_be_unique
    if User.where(slug: slug).where.not(id: id).count > 0
      errors.add(:slug, "must be unique")
    end
  end

  after_save do
    MainChannel.broadcast_update
    UserChannel.user_update(self)
  end

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

  def set_guest_data
    return if self.account_level != 'guest'
    self.guest_data = true
    self.save
  end

  def self.create(params)
    if params.is_a? Array
      params.each do |entry|
        self.create(entry)
      end
      return
    end
    username = params[:username]
    guest = params[:guest] || false
    return if !username
    user = super(username: username, guest: guest)
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
    loop do
      if User.where(slug: "guest-#{guest_number}").count == 0
        break
      else
        guest_number += 1
      end
    end
    username = "Guest #{guest_number}"
    self.create(username: username, guest: true)
  end

end
