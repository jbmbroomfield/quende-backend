class UserForumSerializer

  include JSONAPI::Serializer

  attributes :forum_slug, :level, :authority

end