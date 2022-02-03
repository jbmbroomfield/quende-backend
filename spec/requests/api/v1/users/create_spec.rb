require "rails_helper"
require "requests/api/v1/users/create_spec_helper"

url = "/api/v1/users"
user_count = User.count

RSpec.describe "Api::V1::Users", type: :request do
  describe "POST/users" do

    it "creates and returns a new user" do
      post url, params: body
      expect(response).to have_http_status(:success)
      expect(attributes).to eq(expected_attributes)
      expect(User.count).to eq(user_count + 1)
    end

    it "rejects mismatched passwords" do
      post url, params: mismatched_body
      p ['response',response]
      expect(response).to have_http_status(:not_acceptable)
      expect(json).to eq({
        password_confirmation: "Passwords do not match."
      })
    end

    it "rejects a username with the same slug as a pre-existing username" do
      post url, params: existing_username_body
      expect(response).to have_http_status(:not_acceptable)
      expect(json).to eq({
        username: "Username unavailable."
      })
    end

    it "rejects a pre-existing email" do
      post url, params: existing_email_body
      expect(response).to have_http_status(:not_acceptable)
      expect(json).to eq({
        email: "Email unavailable."
      })
    end

    it "rejects a pre-existing username and email" do
      post url, params: existing_username_and_email_body
      expect(response).to have_http_status(:not_acceptable)
      expect(json).to eq({
        username: "Username unavailable.",
        email: "Email unavailable."
      })
    end

  end
end