class SubsectionSerializer
  include JSONAPI::Serializer
	attributes :title, :section_id, :slug

  attribute :topic_count do |subsection, params|
    if params[:user]
      subsection.topics.filter { |topic| topic.can_view(params[:user]) }.count
    else
      nil
    end
  end

  attribute :unignored_topic_count do |subsection, params|
    if params[:user]
      subsection.topics.filter { |topic| topic.can_view(params[:user]) && !topic.ignored?(params[:user]) }.count
    else
      nil
    end
  end

  attribute :post_count do |subsection, params|
    if params[:user]
      subsection.topics.filter { |topic| topic.can_view(params[:user]) }
      .reduce(0) { |sum, topic| sum + topic.post_count }
    else
      nil
    end
  end

  attribute :unignored_post_count do |subsection, params|
    if params[:user]
      subsection.topics.filter { |topic| topic.can_view(params[:user]) && !topic.ignored?(params[:user]) }
      .reduce(0) { |sum, topic| sum + topic.post_count }
    else
      nil
    end
  end

  attribute :last_post do |subsection, params|
    if params[:user]
      subsection.last_post(params[:user])
    else
      nil
    end
  end

  attribute :last_unignored_post do |subsection, params|
    if params[:user]
      subsection.last_unignored_post(params[:user])
    else
      nil
    end
  end


end
