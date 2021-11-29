class NotificationSerializer
  include JSONAPI::Serializer
  attributes :category, :object_id, :number, :created_at, :tag, :slug, :superslug
end
