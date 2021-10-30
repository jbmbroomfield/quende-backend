class Topic < ApplicationRecord

	belongs_to :subsection
	has_many :posts
	
	after_save :broadcast_update

	# after_save do
	# 	ActionCable.server.broadcast('main_channel', type: 'update')
	# end

end
