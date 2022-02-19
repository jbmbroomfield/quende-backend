require 'rails_helper'
require 'models/forum_spec_helper.rb'

RSpec.describe Forum, type: :model do
  it 'can create a forum' do
    forum = Forum.new(user: user1, title: 'Test Forum')
    forum.save
    expect(forum.valid?).to eq(true)
  end
end