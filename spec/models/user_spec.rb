require 'rails_helper'
require 'models/user_spec_helper.rb'

RSpec.describe User, type: :model do

  it 'can be created with a password' do
    user = User.new(user_create_with_password_successful_params)
    expect(user.save).to eq(true)
  end

  it 'requires unique slugs' do
    User.create(user_create_with_password_successful_params)
    user = User.new(user_create_with_password_successful_params)
    expect(user.save).to eq(false)
    expect(user.errors.full_messages).to eq(["Slug must be unique"])
  end

end
