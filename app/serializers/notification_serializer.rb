class NotificationSerializer
  include FastJsonapi::ObjectSerializer
  attributes :category, :object_id, :number, :created_at, :tag
end
