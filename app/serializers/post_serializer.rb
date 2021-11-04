class PostSerializer
  include JSONAPI::Serializer
  attributes :user_id, :text, :tag, :topic_id, :created_at
end
