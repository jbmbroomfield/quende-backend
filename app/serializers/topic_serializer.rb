class TopicSerializer
  include JSONAPI::Serializer
  attributes :title, :subsection_slug, :posters, :post_count, :first_poster, :slug, :user_slug

  attribute :last_post do |topic, params|
    topic.last_post(params[:user])
  end

end
