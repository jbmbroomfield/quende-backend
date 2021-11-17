class TopicSerializer
  include JSONAPI::Serializer
  attributes :title, :subsection_slug, :posters, :post_count, :first_poster, :slug, :user_slug, :status, :who_can_post, :who_can_view

  attribute :can_view do |topic, params|
    topic.can_view(params[:user])
  end

  attribute :can_post do |topic, params|
    topic.can_post(params[:user])
  end

  attribute :last_post do |topic, params|
    topic.last_post(params[:user])
  end

end
