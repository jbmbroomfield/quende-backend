require 'rails_helper'

RSpec.describe Forum, type: :model do

  it 'can be created' do
    forum = Forum.create(title: 'Test Create Forum')
    expect(forum.save).to eq(true)
  end

  it 'sets the slug based on the title' do
    forum = Forum.create(title: 'Test Slug Forum')
    expect(forum.slug).to eq('test-slug-forum')
    forum2 = Forum.create(title: 'Test Slug Forum')
    expect(forum2.slug).to eq('test-slug-forum-2')
  end

  it 'sets the given user to be an admin' do
    user = User.create(username: 'Test User')
    forum = Forum.create(title: 'Test User Admin Forum', user: user)
    expect(forum.admins.count).to eq(1)
    expect(forum.admins.first).to eq(user)
  end

end