require 'rails_helper'

RSpec.describe Topic, type: :model do
  it 'can be created' do
    topic = Topic.new(title: 'Test Topic', subsection_id: 1)
    expect(topic.save).to eq(true)
  end
end
