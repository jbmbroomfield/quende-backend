class Topic < ApplicationRecord

	belongs_to :subsection
	has_many :posts

end
