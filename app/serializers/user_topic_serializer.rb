class UserTopicSerializer
  include JSONAPI::Serializer
  attributes :user_id, :topic_slug, :subscribed
end
