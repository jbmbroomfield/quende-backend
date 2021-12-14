class TopicSerializer
  include JSONAPI::Serializer
  attributes :title, :subsection_slug, :post_count, :first_poster, :slug, :user_slug, :status, :who_can_post, :who_can_view, :guest_access, :password

  attribute :can_post do |topic, params|
    if params[:quick]
      nil
    else
      topic.can_post(params[:user], params[:passwords])
    end
  end

  attribute :posters do |topic, params|
    if params[:quick]
      nil
    else
      topic.posters_serialized
    end
  end
  
  attribute :viewers do |topic, params|
    if params[:quick]
      nil
    else
      topic.viewers_serialized
    end
  end

  attribute :last_post do |topic, params|
    topic.last_post(params[:user])
  end

end
