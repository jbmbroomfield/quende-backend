require 'rails_helper'

RSpec.describe PasswordAuthentication, type: :model do
  it "can be created" do
    password_authentication = PasswordAuthentication.new(
      user_id: 1,
      password: 'test_pw',
      password_confirmation: 'test_pw',
    )
    expect(password_authentication.save).to eq(true)
  end
end
