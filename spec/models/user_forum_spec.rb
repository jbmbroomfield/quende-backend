require 'rails_helper'

RSpec.describe UserForum, type: :model do
  
  it 'can be created' do
    user = User.create(username: 'Test User')
    forum = Forum.create(title: 'Test Forum')
    user_forum = UserForum.create(user: user, forum: forum)
    expect(user_forum.save).to eq(true)
  end
  
end
