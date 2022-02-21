require 'rails_helper'
require 'models/user_spec_helper.rb'

RSpec.describe User, type: :model do

  it 'can create a member with a password' do
    user = User.create_member(user_create_with_password_successful_params)
    expect(user.valid?).to eq(true)
  end

  it 'sets up the password_authentication correctly' do
    user = User.create_member(user_create_with_password_successful_params)
    expect(user.authentication).not_to be(nil)
    expect(user.authentication.password_authentication).not_to be(nil)
    expect(user.authenticate(password: user_create_with_password_successful_params[:password])).to eq(true)
    expect(user.authenticate(password: 'wrong-password')).to eq(false)
  end

  it 'sets up the email correctly' do
    user = User.create_member(user_create_with_password_successful_params)
    expect(user.email).not_to be(nil)
    expect(user.email.confirmed).to eq(false)
    expect(user.email.address).to eq(user_create_with_password_successful_params[:email_address])
  end

  it 'requires unique slugs' do
    User.create_member(user_create_with_password_successful_params)
    user = User.create_member(user_create_with_password_successful_params)
    expect(user.valid?).to eq(false)
    expect(user.errors.full_messages).to eq(["Slug must be unique"])
  end

  it 'creates guests' do
    guest = User.create_guest
    expect(guest.username).to eq("Guest 1")
    expect(guest.slug).to eq("guest-1")
    expect(guest.guest?).to eq(true)
    guest2 = User.create_guest
    expect(guest2.username).to eq("Guest 2")
    expect(guest2.slug).to eq("guest-2")
  end

end
