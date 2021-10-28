class TopicSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :subsection_id
end
