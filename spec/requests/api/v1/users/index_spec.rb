require "rails_helper"
require "requests/api/v1/users/index_spec_helper"

url = "/api/v1/users"

RSpec.describe "Api::V1::Users", type: :request do
  describe "GET /users" do
    
    it "returns an array of all users" do
      get url
      expect(response).to have_http_status(:ok)
      expect(data.length).to eq(User.count)
      expect(data[0][:attributes]).to eq(user1_attributes)
      expect(data[1][:attributes]).to eq(user2_attributes)
    end

    it "does not include guest users" do
      User.create_guest
      get url
      expect(data.length).to eq(User.count - 1)
    end

  end
end

