require "rails_helper"
require "requests/api/v1/users/create_spec_helper"

url = "/api/v1/users"
user_count = User.count

RSpec.describe "Api::V1::Users", type: :request do
  describe "POST users" do

    it "creates and returns a new user" do
      post url, params: user_create_successful_body
      expect(response).to have_http_status(:success)
      expect(attributes).to eq(user_create_expected_attributes)
      expect(User.count).to eq(user_count + 1)
    end

    it "rejects a username with the same slug as a pre-existing username" do
      post url, params: user_create_existing_username_body
      expect(response).to have_http_status(:not_acceptable)
      expect(json).to eq({
        errors: {
          username: "Username unavailable."
        }
      })
    end

  end
end