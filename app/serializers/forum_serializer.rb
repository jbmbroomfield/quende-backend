class ForumSerializer
  
  include JSONAPI::Serializer

  attributes :title, :slug, :description, :permissions

end