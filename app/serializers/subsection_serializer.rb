class SubsectionSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title
  belongs_to :section
end
