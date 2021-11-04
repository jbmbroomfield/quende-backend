class FlagSerializer
  include JSONAPI::Serializer
  attributes :user_id, :post_id, :category
end
