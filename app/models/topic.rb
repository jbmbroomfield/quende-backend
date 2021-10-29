class Topic < ApplicationRecord

	belongs_to :subsection
	has_many :posts

	accepts_nested_attributes_for :posts

	def post=(params)
		self.save
		new_post = Post.new(params)
		new_post.topic_id = self.id
		new_post.save
	end

end
