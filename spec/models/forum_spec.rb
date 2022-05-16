require 'rails_helper'
require 'models/helpers/forum_spec_helper.rb'

RSpec.describe Forum, type: :model do

  it 'can create a forum' do
    forum = Forum.create(title: 'Test Forum', description: 'A test forum')
    expect(forum.valid?).to eq(true)
    expect(forum.title).to eq('Test Forum')
    expect(forum.description).to eq('A test forum')
    expect(forum.slug).to eq('test-forum')
  end

  it 'can add and remove admins' do
    forum = Forum.create(title: 'Test Forum', description: 'A test forum')
    expect(forum.super_admin?(user2)).to eq(false)
    expect(forum.admin?(user2)).to eq(false)
    expect(forum.super_admins.count).to eq(0)
    expect(forum.admins.count).to eq(0)

    forum.make_admin(user2)
    expect(forum.super_admin?(user2)).to eq(false)
    expect(forum.admin?(user2)).to eq(true)
    expect(forum.super_admins.count).to eq(0)
    expect(forum.admins.count).to eq(1)

    forum.make_super_admin(user2)
    expect(forum.super_admin?(user2)).to eq(true)
    expect(forum.admin?(user2)).to eq(true)
    expect(forum.super_admins.count).to eq(1)
    expect(forum.admins.count).to eq(1)
    
    forum.remove_admin(user2)
    expect(forum.super_admin?(user2)).to eq(false)
    expect(forum.admin?(user2)).to eq(false)
    expect(forum.super_admins.count).to eq(0)
    expect(forum.admins.count).to eq(0)
  end

  it 'can manage permissions' do
    forum = Forum.create(title: 'Test Forum', description: 'A test forum')
    forum.update_permissions(
      view: -1,
      post: 0,
      create_topic: 1,
    )
    expect(forum.permissions['view']).to eq(-1)
    expect(forum.permissions['post']).to eq(0)
    expect(forum.permissions['create_topic']).to eq(1)
    expect(forum.can_view?(-1)).to eq(true)
    expect(forum.can_post?(-1)).to eq(false)
    expect(forum.can_create_topic?(0)).to eq(false)
    expect(forum.can_create_topic?(1)).to eq(true)
  end

end
