class Subsection < ApplicationRecord

  	belongs_to :section
	has_many :topics

end
