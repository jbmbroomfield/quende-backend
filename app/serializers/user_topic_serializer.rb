class UserTopicSerializer
  include FastJsonapi::ObjectSerializer
  attributes :user_id, :topic_id, :subscribed
end
