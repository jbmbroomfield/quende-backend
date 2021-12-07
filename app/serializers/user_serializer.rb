class UserSerializer
  include Rails.application.routes.url_helpers
  include JSONAPI::Serializer
  attributes :username, :get_avatar_image, :page_size, :time_zone, :slug, :account_level, :guest_data

  def get_avatar_image
    if object.avatar_image.attached?
        # {
        #   url: rails_blob_url(object.avatar_image)
        # }
        rails_blob_path(object.avatar_image, only_path: true)
    end
  end

end
