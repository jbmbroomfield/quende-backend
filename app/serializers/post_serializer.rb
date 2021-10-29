class PostSerializer
  include FastJsonapi::ObjectSerializer
  attributes :user_id, :text, :tag, :topic_id, :created_at
end
