class UserTopicSerializer
  include JSONAPI::Serializer
  attributes :subsection_slug, :topic_slug, :subscribed, :status
end
