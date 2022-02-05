class UserSerializer
  include Rails.application.routes.url_helpers
  include JSONAPI::Serializer
  attributes :username, :slug, :guest

  attribute :avatar do |user|
    user.get_avatar_image
  end

end
