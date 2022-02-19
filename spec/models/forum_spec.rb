require 'rails_helper'
require 'models/forum_spec_helper.rb'

RSpec.describe Forum, type: :model do

  it 'can create a forum' do
    forum = Forum.create(user: user1, title: 'Test Forum')
    expect(forum.valid?).to eq(true)
  end

  it 'makes the creating user a super admin' do
    forum = Forum.new(user: user1, title: 'Test Forum')
    expect(forum.super_admin?(user1)).to eq(true)
    expect(forum.admin?(user1)).to eq(true)
    expect(forum.super_admins.count).to eq(1)
    expect(forum.admins.count).to eq(1)
  end

  it 'can add and remove admins' do
    forum = Forum.new(user: user1, title: 'Test Forum')
    expect(forum.super_admin?(user2)).to eq(false)
    expect(forum.admin?(user2)).to eq(false)
    expect(forum.super_admins.count).to eq(1)
    expect(forum.admins.count).to eq(1)
    forum.make_admin(user2)
    expect(forum.super_admin?(user2)).to eq(false)
    expect(forum.admin?(user2)).to eq(true)
    expect(forum.super_admins.count).to eq(1)
    expect(forum.admins.count).to eq(2)
    forum.make_super_admin(user2)
    expect(forum.super_admin?(user2)).to eq(true)
    expect(forum.admin?(user2)).to eq(true)
    expect(forum.super_admins.count).to eq(2)
    expect(forum.admins.count).to eq(2)
    forum.remove_admin(user2)
    expect(forum.super_admin?(user2)).to eq(false)
    expect(forum.admin?(user2)).to eq(false)
    expect(forum.super_admins.count).to eq(1)
    expect(forum.admins.count).to eq(1)
  end

end
