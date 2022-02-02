class UserSerializer
  include Rails.application.routes.url_helpers
  include JSONAPI::Serializer
  attributes :username, :time_zone, :slug, :account_level

  attribute :avatar do |user|
    user.get_avatar_image
  end

end
