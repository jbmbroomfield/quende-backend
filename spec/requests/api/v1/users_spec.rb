require 'rails_helper'

user1_attributes = {
  username: "Jim"
}

RSpec.describe "Api::V1::Users", type: :request do

  describe "GET index" do
    it "returns http success" do
      get "/api/v1/users"
      expect(response).to have_http_status(:success)
    end
    it "returns data" do
      get "/api/v1/users"
      expect(data.length).to eq(3)
      expect(data[0][:attributes]).to eq(user1_attributes)
    end
  end

  describe "GET show" do
    it "returns http success and the correct data" do
      get "/api/v1/users/1"
      expect(response).to have_http_status(:success)
      expect(data[:attributes]).to eq(user1_attributes)
    end
  end

  describe "POST create" do
    it "returns http created and creates a new user" do
      body = {
        "user": {
          "username": "Chris",
          "password_authentication_attributes": {
              "password": "chris",
              "password_confirmation": "chris"
          }
        }
      }
      post "/api/v1/users", params: body
      expect(response).to have_http_status(:created)
      expect(User.count).to eq(4)
    end
  end

end
