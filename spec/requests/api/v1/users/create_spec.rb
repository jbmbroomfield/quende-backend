require "rails_helper"
require "requests/api/v1/users/helpers/create_spec_helper"

url = "/api/v1/users"

RSpec.describe "Api::V1::Users", type: :request do
  describe "POST /users" do

    it "creates and returns a new user" do
      user_count = User.count
      post url, params: user_create_successful_body
      expect(response).to have_http_status(:created)
      expect(attributes).to eq(user_create_expected_attributes)
      expect(User.count).to eq(user_count + 1)
    end

    it "rejects a username with the same slug as a pre-existing username" do
      authentication_count = Authentication.count
      password_authentication_count = PasswordAuthentication.count
      email_count = Email.count
      post url, params: user_create_existing_username_body
      expect(response).to have_http_status(:forbidden)
      expect(json).to eq({
        errors: {
          "register-username-input": "Username unavailable."
        }
      })
      expect(Authentication.count).to eq(authentication_count)
      expect(PasswordAuthentication.count).to eq(password_authentication_count)
      expect(Email.count).to eq(email_count)
    end

  end
end