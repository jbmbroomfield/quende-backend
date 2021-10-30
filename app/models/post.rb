class Post < ApplicationRecord
	
	belongs_to :user
	belongs_to :topic

	before_save do
        if !self.id
            self.tag = self.topic.posts.count.to_s
        end
	end

end
