class TopicSerializer
  include JSONAPI::Serializer
  attributes :title, :subsection_id
  has_many :posts
end
