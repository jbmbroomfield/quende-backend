require "rails_helper"

url = "/api/v1/current_user"

RSpec.describe "Api::V1::Auth", type: :request do
  describe "GET /current_user" do
  
    it "returns a guest jwt and attributes when not logged in" do
      get url
      expect(response).to have_http_status(:success)
      expect(jwt).to be_a(String)
      expect(jwt.length).to eq(84)
      attributes = json[:user][:data][:attributes]
      expect(attributes).to eq({
        username: "Guest 1",
        slug: "guest-1",
        guest: true,
        avatar: nil,
      })
    end

    it "supports multiple guests" do
      get url
      get url
      expect(json[:user][:data][:attributes][:slug]).to eq('guest-2')
      get url
      expect(json[:user][:data][:attributes][:slug]).to eq('guest-3')
    end

    it "returns current user attributes when a jwt is provided" do
      get url, headers: user1_headers
      expect(attributes).to eq(user1_attributes)
    end
  
  end
end