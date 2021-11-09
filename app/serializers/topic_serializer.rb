class TopicSerializer
  include JSONAPI::Serializer
  attributes :title, :subsection_id, :posters, :post_count, :first_poster

  attribute :last_post do |topic, params|
    topic.last_post(params[:user])
  end

end
