class ForumSerializer
  
  include JSONAPI::Serializer

  attributes :title, :slug

end