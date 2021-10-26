require 'rails_helper'

topic1_attributes = {
  title: "First Topic",
}

RSpec.describe "Api::V1::Topics", type: :request do

  describe "GET index" do
    it "returns http success" do
      get "/api/v1/subsections/1/topics"
      expect(response).to have_http_status(:success)
    end
    it "returns data" do
      get "/api/v1/subsections/1/topics"
      expect(data.length).to eq(2)
      expect(data[0][:attributes]).to eq(topic1_attributes)
    end
  end

  describe "GET show" do
    it "returns http success" do
      get "/api/v1/topics/1"
      expect(response).to have_http_status(:success)
    end
    it "returns data" do
      get "/api/v1/topics/1"
      expect(data[:attributes]).to eq(topic1_attributes)
    end
  end

  describe "POST create" do
    it "returns http created and creates a new topic" do
      body = {
        "topic": {
          "title": "Test Topic"
        }
      }
      headers = {
        "Authorization": user2_auth
      }
      post "/api/v1/subsections/1/topics", params: body, headers: headers
      expect(response).to have_http_status(:created)
      expect(Topic.last.title).to eq('Test Topic')
      expect(Topic.count).to eq(4)
    end
  end

end
