class ApplicationRecord < ActiveRecord::Base

    self.abstract_class = true

	def broadcast_main_update
		MainChannel.broadcast_update
	end

end
