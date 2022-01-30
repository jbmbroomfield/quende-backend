class Forum < ApplicationRecord

  include SlugHelper

  has_many :sections

  before_create :set_slug_from_title

end