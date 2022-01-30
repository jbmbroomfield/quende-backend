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

end