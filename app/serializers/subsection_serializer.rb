class SubsectionSerializer
  include JSONAPI::Serializer
	attributes :title, :section_id, :slug

  attribute :topic_count do |subsection, params|
    subsection.topics.filter { |topic| topic.can_view(params[:user]) }.count
  end

  attribute :post_count do |subsection, params|
    subsection.topics.filter { |topic| topic.can_view(params[:user]) }
    .reduce(0) { |sum, topic| sum + topic.post_count }
  end

  attribute :last_post do |subsection, params|
    subsection.last_post(params[:user])
  end

end
