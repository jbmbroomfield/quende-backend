class UserForumSerializer

  include JSONAPI::Serializer

  attributes :level, :authority

end