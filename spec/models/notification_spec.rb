require 'rails_helper'

RSpec.describe Notification, type: :model do
  it 'can be created' do
    notification = Notification.new(user_id: 1, category: 'replies', object_id: 1, number: 1)
    expect(notification.save).to eq(true)
  end
end
