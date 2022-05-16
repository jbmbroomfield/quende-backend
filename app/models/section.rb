class Section < ApplicationRecord

  has_many :subsections
  belongs_to :forum
	
	after_save :broadcast_main_update

end
