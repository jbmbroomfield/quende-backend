class Post < ApplicationRecord
	
	belongs_to :user
	belongs_to :topic

	def save
		if !self.id
			self.tag = self.topic.posts.count.to_s
		end
		super
	end

end
