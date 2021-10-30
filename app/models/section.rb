class Section < ApplicationRecord

    has_many :subsections
	
	after_save :broadcast_update

end
