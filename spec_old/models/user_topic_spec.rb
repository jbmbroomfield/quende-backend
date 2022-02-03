require 'rails_helper'

RSpec.describe UserTopic, type: :model do
  it 'can be created' do
    user_topic = UserTopic.new(user_id: 1, topic_id: 1, subscribed: false)
    expect(user_topic.save).to eq(true)
  end
end
