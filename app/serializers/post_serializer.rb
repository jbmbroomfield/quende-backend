class PostSerializer
  include FastJsonapi::ObjectSerializer
  attributes :user_id, :text, :tag
end
