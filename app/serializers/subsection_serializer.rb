class SubsectionSerializer
  include JSONAPI::Serializer
	attributes :title, :section_id, :topic_count, :post_count

  attribute :last_post do |subsection, params|
    subsection.last_post(params[:user])
  end

end
