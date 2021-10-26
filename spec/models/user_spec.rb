require 'rails_helper'

RSpec.describe User, type: :model do
  it 'can be created' do
    user = User.new(username: 'Test User', email: 'test@user.com')
    expect(user.save).to eq(true)
  end
end
