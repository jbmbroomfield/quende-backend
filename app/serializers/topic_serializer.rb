class TopicSerializer
  include JSONAPI::Serializer
  attributes :title, :subsection_id, :posters
  # has_many :posts
end
