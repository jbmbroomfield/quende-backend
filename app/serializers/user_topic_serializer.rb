class UserTopicSerializer
  include JSONAPI::Serializer
  attributes :user_id, :topic_id, :subscribed
end
