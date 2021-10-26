require 'rails_helper'

RSpec.describe Post, type: :model do
  it 'can be created' do
    post = Post.new(user_id: 1, topic_id: 1, text: 'Test Post')
    expect(post.save).to eq(true)
  end
end
