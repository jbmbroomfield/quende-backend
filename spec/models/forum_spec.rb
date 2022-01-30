require 'rails_helper'

RSpec.describe Forum, type: :model do
  it 'can be created' do
    forum = Forum.create(title: 'Test Forum')
    expect(forum.save).to eq(true)
  end
end