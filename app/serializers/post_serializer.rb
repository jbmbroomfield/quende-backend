class PostSerializer
  include JSONAPI::Serializer
  attributes :user_id, :text, :tag, :topic_id, :created_at

  attribute :my_flags do |post, params|
    post.my_flags(params[:user])
  end

end
