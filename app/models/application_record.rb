class ApplicationRecord < ActiveRecord::Base

    self.abstract_class = true

	def broadcast_update
		ActionCable.server.broadcast('main_channel', type: 'update')
	end

end
