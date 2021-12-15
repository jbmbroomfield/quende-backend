class UserSerializer
  include Rails.application.routes.url_helpers
  include JSONAPI::Serializer
  attributes :username, :get_avatar_image, :page_size, :time_zone, :slug, :account_level, :guest_data, :show_ignored

  def get_avatar_image
    if object.avatar_image.attached?
        rails_blob_path(object.avatar_image, only_path: true)
    end
  end

end
